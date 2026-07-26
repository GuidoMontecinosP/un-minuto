extends Control


# =========================================================
# NODOS
# =========================================================

@onready var nombre = $CajaDialogo/Nombre
@onready var texto = $CajaDialogo/Texto
@onready var reloj = $Reloj
@onready var timer = $Timer
@onready var timer_texto = $TimerTexto
@onready var timer_auto_avance = $TimerAutoAvance
@onready var chica = $Chica
@onready var contador_clicks = $ContadorClicks


# =========================================================
# CONSTANTES
# =========================================================

const SPRITE_BASE := "res://sprites/"
const SPRITE_DEFAULT := "ella_neutral.png"

const TIEMPO_TOTAL := 60
const SAVE_PATH := "user://progreso_1minuto.save"

const TIEMPO_MINIMO_LINEA := 0.30
const VENTANA_RESPUESTA := 3.5

const UMBRAL_BAJO := 4
const UMBRAL_ALTO := 15


# =========================================================
# ESTADO GENERAL
# =========================================================

var dialogos_actuales: Array = []
var indice := 0

var fase_actual := "introduccion"

var tiempo_restante := TIEMPO_TOTAL
var minuto_iniciado := false
var juego_terminado := false

var escribiendo := false
var esperando_siguiente_tramo := false

var velocidad_texto := 0.045
var tiempo_entre_dialogos := 1.15
var hora_inicio_linea := 0.0


# =========================================================
# CLICS
# =========================================================

var cantidad_clicks := 0
var clicks_bloque := 0

var clicks_rapidos := 0
var tiempo_ultimo_click := 0.0

var spam_detectado := false
var modo_rabia := false
var rabia_mostrada := false
var congelado := false

var clicks_al_congelar := 0


# =========================================================
# TRAMOS
# =========================================================

var bloque_actual_numero := 1

var nivel_bloque1 := ""
var nivel_bloque2 := ""


# =========================================================
# RUTAS
# =========================================================

var respondio_tutorial := false
var acepto_reto_clicks := false

var rechazo_reto_clicks := false
var confirmo_que_escucha := false

var se_ofrecio_cita := false
var ruta_romantica := false
var ruta_cobarde := false
var ruta_zen := false

var romance_bloqueado := false


# =========================================================
# PREGUNTAS ESPECIALES
# =========================================================

var pregunta_activa := ""
var pregunta_token := 0


# =========================================================
# PROGRESO
# =========================================================

var progreso := {
	"vio_zen": false,
	"vio_romantica": false,
	"vio_rabia": false,
	"partidas_jugadas": 0
}


# =========================================================
# INTRODUCCIÓN
# El minuto todavía no comienza.
# =========================================================

var dialogos_introduccion := [
	{
		"nombre": "Ella",
		"texto": "¡Ah—!",
		"expresion": "sorprendida",
		"espera": 0.6
	},
	{
		"nombre": "Ella",
		"texto": "...",
		"expresion": "molesta",
		"espera": 0.7
	},
	{
		"nombre": "Ella",
		"texto": "Genial.",
		"expresion": "molesta",
		"espera": 0.8
	},
	{
		"nombre": "Ella",
		"texto": "Choqué contigo.",
		"expresion": "neutral",
		"espera": 0.9
	},
	{
		"nombre": "Ella",
		"texto": "No pongas esa cara.",
		"expresion": "confundida",
		"espera": 0.9
	},
	{
		"nombre": "Ella",
		"texto": "También fue culpa mía.",
		"expresion": "neutral",
		"espera": 1.0
	},
	{
		"nombre": "Ella",
		"texto": "Iba tarde.",
		"expresion": "neutral",
		"espera": 0.8
	},
	{
		"nombre": "Ella",
		"texto": "Ahora voy tarde contigo.",
		"expresion": "coqueta",
		"espera": 1.1
	},
	{
		"nombre": "Ella",
		"texto": "Qué romántico.",
		"expresion": "coqueta",
		"espera": 1.0
	},
	{
		"nombre": "Ella",
		"texto": "Y apareció eso.",
		"expresion": "confundida",
		"espera": 0.9
	},
	{
		"nombre": "Ella",
		"texto": "Un minuto.",
		"expresion": "neutral",
		"espera": 0.9
	},
	{
		"nombre": "Ella",
		"texto": "Conmigo.",
		"expresion": "coqueta",
		"espera": 1.0
	},
	{
		"nombre": "Ella",
		"texto": "Podría ser peor.",
		"expresion": "neutral",
		"espera": 1.0
	}
]


# =========================================================
# INICIO
# =========================================================

func _ready() -> void:
	cargar_progreso()

	timer.wait_time = 1.0
	timer_texto.wait_time = velocidad_texto

	reloj.visible = false
	contador_clicks.visible = false
	contador_clicks.text = "Clics: 0"

	dialogos_actuales = dialogos_introduccion
	indice = 0

	mostrar_dialogo()


# =========================================================
# DIÁLOGOS
# =========================================================

func mostrar_dialogo() -> void:
	if indice >= dialogos_actuales.size():
		terminar_bloque_dialogos()
		return

	var dialogo: Dictionary = dialogos_actuales[indice]

	nombre.text = dialogo.get("nombre", "Ella")
	texto.text = dialogo.get("texto", "")

	var expresion: String = dialogo.get("expresion", "neutral")
	cambiar_expresion(expresion)

	pregunta_activa = ""

	hora_inicio_linea = Time.get_ticks_msec() / 1000.0

	texto.visible_characters = 0
	escribiendo = true

	timer_auto_avance.stop()
	timer_texto.start()


func cambiar_expresion(expresion: String) -> void:
	var ruta := SPRITE_BASE + "ella_" + expresion + ".png"
	var ruta_default := SPRITE_BASE + SPRITE_DEFAULT

	if ResourceLoader.exists(ruta):
		chica.texture = load(ruta)

	elif ResourceLoader.exists(ruta_default):
		chica.texture = load(ruta_default)

	else:
		push_warning(
			"No se encontró la expresión '%s' ni el sprite neutral."
			% expresion
		)


func avanzar_dialogo() -> void:
	if juego_terminado and fase_actual != "final":
		return

	indice += 1

	if indice < dialogos_actuales.size():
		mostrar_dialogo()
	else:
		terminar_bloque_dialogos()


func terminar_bloque_dialogos() -> void:
	match fase_actual:
		"introduccion":
			iniciar_minuto()

		"conversacion":
			if not juego_terminado:
				decidir_siguiente_bloque()

		"final":
			pass


func cargar_bloque(bloque: Array) -> void:
	if juego_terminado and fase_actual != "final":
		return

	if bloque.is_empty():
		decidir_siguiente_bloque()
		return

	esperando_siguiente_tramo = false

	dialogos_actuales = bloque
	indice = 0

	mostrar_dialogo()


# =========================================================
# COMIENZO DEL MINUTO
# =========================================================

func iniciar_minuto() -> void:
	fase_actual = "conversacion"

	minuto_iniciado = true
	juego_terminado = false

	tiempo_restante = TIEMPO_TOTAL

	cantidad_clicks = 0
	contador_clicks.text = "Clics: 0"
	
	clicks_bloque = 0

	bloque_actual_numero = 1

	reloj.visible = true
	actualizar_reloj()

	timer.start()

	cargar_bloque(bloque_1())


func actualizar_reloj() -> void:
	var minutos := int(tiempo_restante / 60)
	var segundos := tiempo_restante % 60

	reloj.text = "%02d:%02d" % [minutos, segundos]


# =========================================================
# CLICS
# =========================================================

func registrar_click() -> void:
	if not minuto_iniciado or juego_terminado:
		return

	cantidad_clicks += 1
	clicks_bloque += 1

	if contador_clicks.visible:
		contador_clicks.text = "Clics: " + str(cantidad_clicks)

	var momento_actual := Time.get_ticks_msec() / 1000.0
	var diferencia := momento_actual - tiempo_ultimo_click

	if tiempo_ultimo_click > 0.0 and diferencia < 0.35:
		clicks_rapidos += 1

		if clicks_rapidos >= 5:
			spam_detectado = true
			romance_bloqueado = true

		if (
			clicks_rapidos >= 12
			and not congelado
			and not rabia_mostrada
		):
			congelar_por_rabia()
	else:
		clicks_rapidos = 0

	tiempo_ultimo_click = momento_actual


func _on_avanzar_pressed() -> void:
	registrar_click()

	if pregunta_activa != "":
		responder_pregunta()
		return

	if esperando_siguiente_tramo:
		return

	if congelado:
		return

	if juego_terminado and fase_actual != "final":
		return

	var ahora := Time.get_ticks_msec() / 1000.0

	if ahora - hora_inicio_linea < TIEMPO_MINIMO_LINEA:
		return

	if escribiendo:
		texto.visible_characters = -1
		escribiendo = false

		timer_texto.stop()
		finalizar_linea()

		return

	if not timer_auto_avance.is_stopped():
		timer_auto_avance.stop()
		avanzar_dialogo()


# =========================================================
# MÁQUINA DE ESCRIBIR
# =========================================================

func _on_timer_texto_timeout() -> void:
	texto.visible_characters += 1

	if texto.visible_characters >= texto.get_total_character_count():
		escribiendo = false
		timer_texto.stop()

		finalizar_linea()


func finalizar_linea() -> void:
	if indice >= dialogos_actuales.size():
		return

	var dialogo: Dictionary = dialogos_actuales[indice]
	var pregunta: String = dialogo.get("pregunta", "")

	if pregunta != "":
		iniciar_pregunta(
			pregunta,
			dialogo.get("ventana", VENTANA_RESPUESTA)
		)
	else:
		iniciar_espera_autoavance()


func iniciar_espera_autoavance() -> void:
	if congelado:
		return

	if juego_terminado and fase_actual != "final":
		return

	var espera := tiempo_entre_dialogos

	if indice < dialogos_actuales.size():
		espera = dialogos_actuales[indice].get(
			"espera",
			tiempo_entre_dialogos
		)

	timer_auto_avance.wait_time = espera
	timer_auto_avance.start()


func _on_timer_auto_avance_timeout() -> void:
	avanzar_dialogo()


# =========================================================
# PREGUNTAS
# =========================================================

func iniciar_pregunta(tipo: String, duracion: float) -> void:
	pregunta_activa = tipo
	pregunta_token += 1

	var token_actual := pregunta_token

	get_tree().create_timer(duracion).timeout.connect(
		func():
			responder_pregunta_por_tiempo(token_actual)
	)


func responder_pregunta() -> void:
	if pregunta_activa == "":
		return

	var tipo := pregunta_activa

	pregunta_activa = ""
	pregunta_token += 1

	match tipo:
		"tutorial":
			resolver_tutorial(true)

		"sigues_ahi":
			resolver_sigues_ahi(true)

		"cita":
			resolver_cita(true)


func responder_pregunta_por_tiempo(token: int) -> void:
	if token != pregunta_token:
		return

	if pregunta_activa == "":
		return

	var tipo := pregunta_activa

	pregunta_activa = ""
	pregunta_token += 1

	match tipo:
		"tutorial":
			resolver_tutorial(false)

		"sigues_ahi":
			resolver_sigues_ahi(false)

		"cita":
			resolver_cita(false)


func insertar_despues(reacciones: Array) -> void:
	var posicion := indice + 1

	for reaccion in reacciones:
		dialogos_actuales.insert(posicion, reaccion)
		posicion += 1

	avanzar_dialogo()


# =========================================================
# RESPUESTA AL TUTORIAL
# =========================================================

func resolver_tutorial(respondio: bool) -> void:
	if respondio:
		respondio_tutorial = true
		contador_clicks.visible = true
		contador_clicks.text = "Clics: " + str(cantidad_clicks)

		insertar_despues([
			{
				"nombre": "Ella",
				"texto": "Oh.",
				"expresion": "sorprendida",
				"espera": 0.8
			},
			{
				"nombre": "Ella",
				"texto": "Sí me estabas escuchando.",
				"expresion": "coqueta",
				"espera": 1.2
			},
			{
				"nombre": "Ella",
				"texto": "Qué atento.",
				"expresion": "coqueta",
				"espera": 1.0
			},
			{
				"nombre": "Ella",
				"texto": "Entonces ya tenemos un idioma.",
				"expresion": "neutral",
				"espera": 1.3
			},
			{
				"nombre": "Ella",
				"texto": "Uno bastante limitado.",
				"expresion": "confundida",
				"espera": 1.2
			},
			{
				"nombre": "Ella",
				"texto": "Aunque puedes hacer más clics, si quieres.",
				"expresion": "coqueta",
				"espera": 1.3
			},
			{
				"nombre": "Ella",
				"texto": "A ver cuántos aguantas.",
				"expresion": "coqueta",
				"espera": 1.3
			},
			{
				"nombre": "Ella",
				"texto": "Te reto.",
				"expresion": "molesta",
				"espera": 1.0
			}
		])

	else:
		respondio_tutorial = false

		insertar_despues([
			{
				"nombre": "Ella",
				"texto": "...",
				"expresion": "confundida",
				"espera": 0.9
			},
			{
				"nombre": "Ella",
				"texto": "Bueno.",
				"expresion": "neutral",
				"espera": 0.9
			},
			{
				"nombre": "Ella",
				"texto": "Esto va a ser una conversación difícil.",
				"expresion": "coqueta",
				"espera": 1.4
			}
		])


# =========================================================
# COMPROBAR SI SIGUE ESCUCHANDO
# =========================================================

func resolver_sigues_ahi(respondio: bool) -> void:
	if respondio and not romance_bloqueado:
		confirmo_que_escucha = true

		insertar_despues([
			{
				"nombre": "Ella",
				"texto": "Ah.",
				"expresion": "sorprendida",
				"espera": 0.8
			},
			{
				"nombre": "Ella",
				"texto": "Sí estabas escuchando.",
				"expresion": "coqueta",
				"espera": 1.2
			},
			{
				"nombre": "Ella",
				"texto": "Todo un caballero.",
				"expresion": "coqueta",
				"espera": 1.1
			},
			{
				"nombre": "Ella",
				"texto": "No hablas mucho.",
				"expresion": "neutral",
				"espera": 1.1
			},
			{
				"nombre": "Ella",
				"texto": "Pero respondes cuando importa.",
				"expresion": "sonrojada",
				"espera": 1.4
			}
		])

	else:
		confirmo_que_escucha = false
		ruta_zen = true

		insertar_despues([
			{
				"nombre": "Ella",
				"texto": "...",
				"expresion": "confundida",
				"espera": 1.0
			},
			{
				"nombre": "Ella",
				"texto": "Vaya.",
				"expresion": "neutral",
				"espera": 0.9
			},
			{
				"nombre": "Ella",
				"texto": "De verdad eres imperturbable.",
				"expresion": "coqueta",
				"espera": 1.3
			},
			{
				"nombre": "Ella",
				"texto": "O estás AFK.",
				"expresion": "confundida",
				"espera": 1.2
			}
		])


# =========================================================
# RESPUESTA A LA CITA
# =========================================================

func resolver_cita(respondio: bool) -> void:
	if respondio and confirmo_que_escucha and not romance_bloqueado:
		ruta_romantica = true

		insertar_despues([
			{
				"nombre": "Ella",
				"texto": "...",
				"expresion": "muy_sonrojada",
				"espera": 1.0
			},
			{
				"nombre": "Ella",
				"texto": "Mira tú.",
				"expresion": "coqueta",
				"espera": 1.0
			},
			{
				"nombre": "Ella",
				"texto": "Intentando ligar con un dibujo.",
				"expresion": "coqueta",
				"espera": 1.5
			},
			{
				"nombre": "Ella",
				"texto": "No sé si es triste...",
				"expresion": "neutral",
				"espera": 1.4
			},
			{
				"nombre": "Ella",
				"texto": "o atrevido.",
				"expresion": "sonrojada",
				"espera": 1.3
			},
			{
				"nombre": "Ella",
				"texto": "Un poco de ambos.",
				"expresion": "muy_sonrojada",
				"espera": 1.4
			},
			{
				"nombre": "Ella",
				"texto": "No pongas esa cara.",
				"expresion": "molesta",
				"espera": 1.1
			}
		])

	elif not respondio and confirmo_que_escucha:
		ruta_cobarde = true

		insertar_despues([
			{
				"nombre": "Ella",
				"texto": "...",
				"expresion": "neutral",
				"espera": 1.0
			},
			{
				"nombre": "Ella",
				"texto": "Qué prudente.",
				"expresion": "confundida",
				"espera": 1.1
			},
			{
				"nombre": "Ella",
				"texto": "También qué inútil.",
				"expresion": "molesta",
				"espera": 1.2
			},
			{
				"nombre": "Ella",
				"texto": "Las oportunidades no suelen avisar dos veces.",
				"expresion": "neutral",
				"espera": 1.6
			},
			{
				"nombre": "Ella",
				"texto": "Nunca sabes cuándo algo bueno iba a pasar.",
				"expresion": "coqueta",
				"espera": 1.6
			},
			{
				"nombre": "Ella",
				"texto": "Cobarde.",
				"expresion": "coqueta",
				"espera": 1.0
			}
		])

	else:
		avanzar_dialogo()


# =========================================================
# TIMER PRINCIPAL
# =========================================================

func _on_timer_timeout() -> void:
	if not minuto_iniciado or juego_terminado:
		return

	tiempo_restante -= 1
	actualizar_reloj()

	var transcurrido := TIEMPO_TOTAL - tiempo_restante

	if esperando_siguiente_tramo:
		if bloque_actual_numero == 1 and transcurrido >= 20:
			esperando_siguiente_tramo = false
			cerrar_bloque(1)

		elif bloque_actual_numero == 2 and transcurrido >= 40:
			esperando_siguiente_tramo = false
			cerrar_bloque(2)

	if tiempo_restante <= 0:
		terminar_minuto()


# =========================================================
# ESPERA ENTRE TRAMOS
# =========================================================

func esperar_siguiente_tramo() -> void:
	esperando_siguiente_tramo = true

	timer_texto.stop()
	timer_auto_avance.stop()

	escribiendo = false
	pregunta_activa = ""

	# Mantiene la última frase visible.
	texto.visible_characters = -1


# =========================================================
# CONTROL DE LOS TRAMOS
# =========================================================

func decidir_siguiente_bloque() -> void:
	if juego_terminado or congelado:
		return

	var transcurrido := TIEMPO_TOTAL - tiempo_restante

	match bloque_actual_numero:
		1:
			if transcurrido >= 20:
				cerrar_bloque(1)
			else:
				esperar_siguiente_tramo()

		2:
			if transcurrido >= 40:
				cerrar_bloque(2)
			else:
				esperar_siguiente_tramo()

		3:
			esperar_siguiente_tramo()


func cerrar_bloque(numero: int) -> void:
	esperando_siguiente_tramo = false

	var nivel := calcular_nivel(clicks_bloque)

	if numero == 1:
		nivel_bloque1 = nivel

		acepto_reto_clicks = nivel == "medio" or nivel == "alto"
		rechazo_reto_clicks = nivel == "bajo"

		clicks_bloque = 0
		bloque_actual_numero = 2

		cargar_bloque(bloque_2(nivel_bloque1))

	elif numero == 2:
		nivel_bloque2 = nivel

		clicks_bloque = 0
		bloque_actual_numero = 3

		cargar_bloque(bloque_3(nivel_bloque2))


func calcular_nivel(clicks: int) -> String:
	if clicks <= UMBRAL_BAJO:
		return "bajo"

	elif clicks < UMBRAL_ALTO:
		return "medio"

	else:
		return "alto"


# =========================================================
# BLOQUE 1 — TUTORIAL + RETO
# =========================================================

func bloque_1() -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": "Bueno.",
			"expresion": "neutral",
			"espera": 0.9
		},
		{
			"nombre": "Ella",
			"texto": "Parece que tú no puedes hablar.",
			"expresion": "confundida",
			"espera": 1.3
		},
		{
			"nombre": "Ella",
			"texto": "Conveniente para mí.",
			"expresion": "coqueta",
			"espera": 1.1
		},
		{
			"nombre": "Ella",
			"texto": "Probemos algo.",
			"expresion": "neutral",
			"espera": 1.0
		},
		{
			"nombre": "Ella",
			"texto": "Haz clic si me estás escuchando.",
			"expresion": "coqueta",
			"pregunta": "tutorial",
			"ventana": 3.5
		}
	]


# =========================================================
# BLOQUE 2 — RESULTADO DEL RETO
# =========================================================

func bloque_2(nivel: String) -> Array:
	var lineas: Array = []

	match nivel:
		"bajo":
			lineas = [
				{
					"nombre": "Ella",
					"texto": "Hm.",
					"expresion": "neutral",
					"espera": 0.9
				},
				{
					"nombre": "Ella",
					"texto": "No aceptaste el reto.",
					"expresion": "confundida",
					"espera": 1.2
				},
				{
					"nombre": "Ella",
					"texto": "Qué sospechosamente sensato.",
					"expresion": "coqueta",
					"espera": 1.3
				},
				{
					"nombre": "Ella",
					"texto": "O estás AFK.",
					"expresion": "confundida",
					"espera": 1.1
				},
				{
					"nombre": "Ella",
					"texto": "A ver.",
					"expresion": "neutral",
					"espera": 0.8
				},
				{
					"nombre": "Ella",
					"texto": "Haz clic si sigues ahí.",
					"expresion": "coqueta",
					"pregunta": "sigues_ahi",
					"ventana": 3.5
				}
			]

		"medio":
			lineas = [
				{
					"nombre": "Ella",
					"texto": "Ah.",
					"expresion": "sorprendida",
					"espera": 0.8
				},
				{
					"nombre": "Ella",
					"texto": "Aceptaste.",
					"expresion": "coqueta",
					"espera": 1.0
				},
				{
					"nombre": "Ella",
					"texto": "Pero todavía conservas algo de dignidad.",
					"expresion": "neutral",
					"espera": 1.5
				},
				{
					"nombre": "Ella",
					"texto": "Qué desperdicio.",
					"expresion": "molesta",
					"espera": 1.1
				},
				{
					"nombre": "Ella",
					"texto": "Prueba un poco más.",
					"expresion": "coqueta",
					"espera": 1.2
				},
				{
					"nombre": "Ella",
					"texto": "A ver si logras decepcionarme.",
					"expresion": "coqueta",
					"espera": 1.3
				}
			]

		_:
			lineas = [
				{
					"nombre": "Ella",
					"texto": "Vaya.",
					"expresion": "sorprendida",
					"espera": 0.8
				},
				{
					"nombre": "Ella",
					"texto": "Eso fue fácil.",
					"expresion": "coqueta",
					"espera": 1.0
				},
				{
					"nombre": "Ella",
					"texto": "Solo tuve que retarte.",
					"expresion": "neutral",
					"espera": 1.3
				},
				{
					"nombre": "Ella",
					"texto": "Y tú hiciste el resto.",
					"expresion": "confundida",
					"espera": 1.3
				},
				{
					"nombre": "Ella",
					"texto": "¿Siempre eres tan fácil de manipular?",
					"expresion": "coqueta",
					"espera": 1.5
				},
				{
					"nombre": "Ella",
					"texto": "No respondas.",
					"expresion": "neutral",
					"espera": 0.9
				},
				{
					"nombre": "Ella",
					"texto": "Ya lo hiciste.",
					"expresion": "molesta",
					"espera": 1.1
				}
			]

	return lineas


# =========================================================
# BLOQUE 3
# =========================================================

func bloque_3(nivel: String) -> Array:
	if confirmo_que_escucha and not romance_bloqueado:
		return [
			{
				"nombre": "Ella",
				"texto": "No hablas mucho.",
				"expresion": "neutral",
				"espera": 1.1
			},
			{
				"nombre": "Ella",
				"texto": "Pero respondes cuando te lo pido.",
				"expresion": "coqueta",
				"espera": 1.4
			},
			{
				"nombre": "Ella",
				"texto": "Eso es...",
				"expresion": "sonrojada",
				"espera": 1.0
			},
			{
				"nombre": "Ella",
				"texto": "demasiado atento.",
				"expresion": "muy_sonrojada",
				"espera": 1.2
			},
			{
				"nombre": "Ella",
				"texto": "Tengo otra pregunta.",
				"expresion": "coqueta",
				"espera": 1.2
			},
			{
				"nombre": "Ella",
				"texto": "Haz clic si aceptarías una cita conmigo.",
				"expresion": "sonrojada",
				"pregunta": "cita",
				"ventana": 4.0
			}
		]

	if ruta_zen:
		return [
			{
				"nombre": "Ella",
				"texto": "Supongo que esto también funciona.",
				"expresion": "neutral",
				"espera": 1.3
			},
			{
				"nombre": "Ella",
				"texto": "Yo hablo.",
				"expresion": "confundida",
				"espera": 1.0
			},
			{
				"nombre": "Ella",
				"texto": "Tú contemplas el vacío.",
				"expresion": "coqueta",
				"espera": 1.3
			},
			{
				"nombre": "Ella",
				"texto": "Una conversación bastante eficiente.",
				"expresion": "neutral",
				"espera": 1.4
			}
		]

	match nivel:
		"bajo":
			return [
				{
					"nombre": "Ella",
					"texto": "Te cansaste rápido.",
					"expresion": "confundida",
					"espera": 1.2
				},
				{
					"nombre": "Ella",
					"texto": "O recuperaste el autocontrol.",
					"expresion": "neutral",
					"espera": 1.3
				},
				{
					"nombre": "Ella",
					"texto": "No sé cuál sería más sorprendente.",
					"expresion": "coqueta",
					"espera": 1.4
				}
			]

		"medio":
			return [
				{
					"nombre": "Ella",
					"texto": "Sigues intentándolo.",
					"expresion": "neutral",
					"espera": 1.2
				},
				{
					"nombre": "Ella",
					"texto": "Qué perseverante.",
					"expresion": "coqueta",
					"espera": 1.1
				},
				{
					"nombre": "Ella",
					"texto": "O predecible.",
					"expresion": "molesta",
					"espera": 1.1
				}
			]

		_:
			return [
				{
					"nombre": "Ella",
					"texto": "...",
					"expresion": "molesta",
					"espera": 1.0
				},
				{
					"nombre": "Ella",
					"texto": "¿Sabes qué es lo gracioso?",
					"expresion": "confundida",
					"espera": 1.4
				},
				{
					"nombre": "Ella",
					"texto": "Nunca te dije que dejaras de escucharme.",
					"expresion": "neutral",
					"espera": 1.6
				},
				{
					"nombre": "Ella",
					"texto": "Pero lo hiciste igual.",
					"expresion": "molesta",
					"espera": 1.4
				},
				{
					"nombre": "Ella",
					"texto": "Qué obediente.",
					"expresion": "coqueta",
					"espera": 1.2
				}
			]

	return []


# =========================================================
# SPAM EXTREMO
# =========================================================

func congelar_por_rabia() -> void:
	if congelado or rabia_mostrada:
		return

	congelado = true
	modo_rabia = true
	rabia_mostrada = true

	romance_bloqueado = true

	pregunta_activa = ""
	pregunta_token += 1

	clicks_al_congelar = cantidad_clicks

	timer_texto.stop()
	timer_auto_avance.stop()

	escribiendo = false
	texto.visible_characters = -1

	cambiar_expresion("molesta")

	nombre.text = "Ella"
	texto.text = "..."

	get_tree().create_timer(3.0).timeout.connect(
		_on_fin_congelamiento
	)


func _on_fin_congelamiento() -> void:
	if juego_terminado:
		return

	congelado = false

	var clicks_durante := cantidad_clicks - clicks_al_congelar

	cargar_bloque(
		bloque_post_congelamiento(clicks_durante)
	)


func bloque_post_congelamiento(clicks_durante: int) -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": "¿Ya?",
			"expresion": "molesta",
			"espera": 1.0
		},
		{
			"nombre": "Ella",
			"texto": "¿Terminaste?",
			"expresion": "molesta",
			"espera": 1.1
		},
		{
			"nombre": "Ella",
			"texto": (
				"Seguiste clickeando "
				+ str(clicks_durante)
				+ " veces mientras estaba callada."
			),
			"expresion": "confundida",
			"espera": 1.8
		},
		{
			"nombre": "Ella",
			"texto": "Ni siquiera necesitabas que hablara.",
			"expresion": "neutral",
			"espera": 1.5
		},
		{
			"nombre": "Ella",
			"texto": "Eso explica muchas cosas.",
			"expresion": "coqueta",
			"espera": 1.3
		}
	]


# =========================================================
# FINAL
# =========================================================

func terminar_minuto() -> void:
	juego_terminado = true
	minuto_iniciado = false

	congelado = false
	esperando_siguiente_tramo = false

	pregunta_activa = ""
	pregunta_token += 1

	timer.stop()
	timer_texto.stop()
	timer_auto_avance.stop()

	escribiendo = false

	fase_actual = "final"

	cargar_bloque(construir_bloque_final())


func construir_bloque_final() -> Array:
	actualizar_progreso()
	guardar_progreso()

	var bloque := construir_cuerpo_final()
	bloque.append_array(bloque_despedida())

	return bloque


func construir_cuerpo_final() -> Array:
	if ruta_romantica:
		return [
			{
				"nombre": "Ella",
				"texto": "Mira tú.",
				"expresion": "coqueta",
				"espera": 1.1
			},
			{
				"nombre": "Ella",
				"texto": "Intentando ligar con un dibujo.",
				"expresion": "coqueta",
				"espera": 1.5
			},
			{
				"nombre": "Ella",
				"texto": "No sé si es triste...",
				"expresion": "neutral",
				"espera": 1.4
			},
			{
				"nombre": "Ella",
				"texto": "o atrevido.",
				"expresion": "sonrojada",
				"espera": 1.3
			},
			{
				"nombre": "Ella",
				"texto": "Un poco de ambos.",
				"expresion": "muy_sonrojada",
				"espera": 1.4
			},
			{
				"nombre": "Ella",
				"texto": "No estuvo mal.",
				"expresion": "sonrojada",
				"espera": 1.2
			}
		]

	elif ruta_cobarde:
		return [
			{
				"nombre": "Ella",
				"texto": "Las oportunidades no suelen avisar dos veces.",
				"expresion": "neutral",
				"espera": 1.6
			},
			{
				"nombre": "Ella",
				"texto": "Nunca sabes cuándo algo bueno iba a pasar.",
				"expresion": "coqueta",
				"espera": 1.6
			},
			{
				"nombre": "Ella",
				"texto": "Aunque supongo que eso lo vuelve más fácil.",
				"expresion": "confundida",
				"espera": 1.5
			},
			{
				"nombre": "Ella",
				"texto": "Puedes fingir que no querías.",
				"expresion": "neutral",
				"espera": 1.4
			},
			{
				"nombre": "Ella",
				"texto": "Cobarde.",
				"expresion": "coqueta",
				"espera": 1.0
			}
		]

	elif cantidad_clicks == 0 or ruta_zen:
		return [
			{
				"nombre": "Ella",
				"texto": "Ni uno.",
				"expresion": "sorprendida",
				"espera": 1.1
			},
			{
				"nombre": "Ella",
				"texto": "Dejaste que todo pasara solo.",
				"expresion": "neutral",
				"espera": 1.5
			},
			{
				"nombre": "Ella",
				"texto": "Debe ser cómodo.",
				"expresion": "confundida",
				"espera": 1.2
			},
			{
				"nombre": "Ella",
				"texto": "O aterrador.",
				"expresion": "coqueta",
				"espera": 1.2
			}
		]

	elif modo_rabia:
		return [
			{
				"nombre": "Ella",
				"texto": str(cantidad_clicks) + " clics.",
				"expresion": "molesta",
				"espera": 1.2
			},
			{
				"nombre": "Ella",
				"texto": "Qué frágil es el autocontrol.",
				"expresion": "confundida",
				"espera": 1.4
			},
			{
				"nombre": "Ella",
				"texto": "Ponlo en tu currículum.",
				"expresion": "coqueta",
				"espera": 1.3
			}
		]

	elif nivel_bloque1 == "alto" or nivel_bloque2 == "alto":
		return [
			{
				"nombre": "Ella",
				"texto": str(cantidad_clicks) + " clics.",
				"expresion": "molesta",
				"espera": 1.2
			},
			{
				"nombre": "Ella",
				"texto": "No sabía que tenías tanta prisa.",
				"expresion": "confundida",
				"espera": 1.4
			},
			{
				"nombre": "Ella",
				"texto": "Ni siquiera preguntaste adónde.",
				"expresion": "neutral",
				"espera": 1.4
			},
			{
				"nombre": "Ella",
				"texto": "Ponlo en tu currículum.",
				"expresion": "coqueta",
				"espera": 1.2
			}
		]

	else:
		return [
			{
				"nombre": "Ella",
				"texto": "Eso fue...",
				"expresion": "neutral",
				"espera": 1.0
			},
			{
				"nombre": "Ella",
				"texto": "sorprendentemente normal.",
				"expresion": "confundida",
				"espera": 1.3
			},
			{
				"nombre": "Ella",
				"texto": "No sé si felicitarte.",
				"expresion": "coqueta",
				"espera": 1.3
			},
			{
				"nombre": "Ella",
				"texto": "Así que no lo haré.",
				"expresion": "neutral",
				"espera": 1.1
			}
		]


func bloque_despedida() -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": "Bueno... me tengo que ir.",
			"expresion": "neutral",
			"espera": 1.2
		},
		{
			"nombre": "Ella",
			"texto": "Voy a llegar tarde.",
			"expresion": "confundida",
			"espera": 1.2
		},
		{
			"nombre": "Ella",
			"texto": "Otra vez.",
			"expresion": "neutral",
			"espera": 1.0
		},
		obtener_linea_pista(),
		{
			"nombre": "Ella",
			"texto": "Adiós.",
			"expresion": "ojos_cerrados",
			"espera": 1.0
		}
	]


# =========================================================
# PISTAS
# =========================================================

func obtener_linea_pista() -> Dictionary:
	if not progreso["vio_zen"]:
		return {
			"nombre": "Ella",
			"texto": "La próxima vez podrías no aceptar todos los retos.",
			"expresion": "neutral",
			"espera": 1.7
		}

	elif not progreso["vio_romantica"]:
		return {
			"nombre": "Ella",
			"texto": "A veces una respuesta basta para cambiar una conversación.",
			"expresion": "sonrojada",
			"espera": 1.8
		}

	elif not progreso["vio_rabia"]:
		return {
			"nombre": "Ella",
			"texto": "Fuiste bastante amable con ese botón.",
			"expresion": "confundida",
			"espera": 1.6
		}

	else:
		return {
			"nombre": "Ella",
			"texto": "Supongo que todavía puedes sorprenderme.",
			"expresion": "coqueta",
			"espera": 1.6
		}


# =========================================================
# GUARDADO
# =========================================================

func actualizar_progreso() -> void:
	progreso["partidas_jugadas"] += 1

	if cantidad_clicks == 0 or ruta_zen:
		progreso["vio_zen"] = true

	if ruta_romantica:
		progreso["vio_romantica"] = true

	if modo_rabia:
		progreso["vio_rabia"] = true


func guardar_progreso() -> void:
	var archivo := FileAccess.open(SAVE_PATH, FileAccess.WRITE)

	if archivo:
		archivo.store_var(progreso)
		archivo.close()


func cargar_progreso() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		return

	var archivo := FileAccess.open(SAVE_PATH, FileAccess.READ)

	if not archivo:
		return

	var datos = archivo.get_var()
	archivo.close()

	if typeof(datos) != TYPE_DICTIONARY:
		return

	for clave in progreso.keys():
		if datos.has(clave):
			progreso[clave] = datos[clave]


# =========================================================
# DEBUG
# F9 borra el progreso.
# =========================================================

func _unhandled_input(event: InputEvent) -> void:
	if (
		event is InputEventKey
		and event.pressed
		and event.keycode == KEY_F9
	):
		progreso = {
			"vio_zen": false,
			"vio_romantica": false,
			"vio_rabia": false,
			"partidas_jugadas": 0
		}

		if FileAccess.file_exists(SAVE_PATH):
			DirAccess.remove_absolute(
				ProjectSettings.globalize_path(SAVE_PATH)
			)

		print("Progreso reiniciado.")
