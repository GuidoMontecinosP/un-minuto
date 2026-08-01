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

const VENTANA_RESPUESTA := 5.0

const OBJETIVO_INICIAL := 10

# Clics durante la introducción (antes de que empiece el minuto)
# que hacen que Ella pierda la paciencia y corte la conversación.
const UMBRAL_IMPACIENCIA := 8

# Deben coincidir con los números que tienen easter egg en
# obtener_final_numero_especial(). Techo realista: alguien
# clickeando fuerte llega a ~137, así que ninguno se pasa de ahí.
const NUMEROS_ESPECIALES := [42, 67, 69, 77, 100, 111, 130]


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


# =========================================================
# CLICS
# =========================================================

var cantidad_clicks := 0
var clicks_bloque := 0

var conteo_clicks_habilitado := false

# Clics acumulados durante la introducción, antes de que
# empiece el minuto. No se muestran ni cuentan para ningún
# reto — solo sirven para detectar impaciencia.
var clicks_antes_del_minuto := 0
var ruta_impaciente := false


# =========================================================
# TRAMOS / RETO
# =========================================================

var bloque_actual_numero := 1
var objetivo_actual := OBJETIVO_INICIAL

# El reto tiene su propia ventana de tiempo, independiente
# del cronograma fijo de 20s/40s, para que nunca se coma
# el tiempo real de clickeo con el diálogo de aviso.
const VENTANA_RETO := 10.0
var reto_anunciado := false
var reto_deadline := -1.0


# =========================================================
# RUTAS
# =========================================================

var respondio_tutorial := false

var ruta_reto_activa := false
var reto_completado := false
var ruta_perdedor := false

# Cuántos clics tenías cuando se anunció el objetivo actual.
# Sirve para distinguir "nunca lo intentó" de "lo intentó y
# no le alcanzó".
var clicks_al_anunciar_reto := 0

var confirmo_que_escucha := false

var ruta_romantica := false
var ruta_cobarde := false
var ruta_zen := false
var ruta_indecisa := false

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
	"vio_indecisa": false,
	"vio_romantica": false,
	"vio_impaciente": false,
	"vio_reto_completado": false,
	"vio_perdedor": false,
	"partidas_jugadas": 0,
	"numeros_especiales_vistos": []
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
		"mostrar_reloj": true,
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


func construir_intro_replay() -> Array:
	var num: int = progreso["partidas_jugadas"]

	if num == 1:
		return intro_replay_1()
	elif num == 2:
		return intro_replay_2()
	elif num == 3:
		return intro_replay_3()
	elif num <= 9:
		return intro_replay_generica(num + 1)
	else:
		return intro_replay_corta()


func intro_replay_1() -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": "¿Tú otra vez?",
			"expresion": "confundida",
			"espera": 0.9
		},
		{
			"nombre": "Ella",
			"texto": "Qué casualidad.",
			"expresion": "coqueta",
			"espera": 1.0
		},
		{
			"nombre": "Ella",
			"texto": "O no tanto.",
			"expresion": "molesta",
			"espera": 0.9
		},
		{
			"nombre": "Ella",
			"texto": "Bueno.",
			"expresion": "neutral",
			"espera": 0.8
		},
		{
			"nombre": "Ella",
			"texto": "Otra vez apareció eso.",
			"expresion": "confundida",
			"mostrar_reloj": true,
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
			"texto": "Otra vez conmigo.",
			"expresion": "coqueta",
			"espera": 1.0
		},
		{
			"nombre": "Ella",
			"texto": "Vamos a ver si esta vez sale distinto.",
			"expresion": "neutral",
			"espera": 1.3
		}
	]


func intro_replay_2() -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": "Otra vez tú.",
			"expresion": "confundida",
			"espera": 0.9
		},
		{
			"nombre": "Ella",
			"texto": "Empiezo a pensar que esto no es casualidad.",
			"expresion": "coqueta",
			"espera": 1.4
		},
		{
			"nombre": "Ella",
			"texto": "Bueno, no me quejo.",
			"expresion": "sonrojada",
			"espera": 1.1
		},
		{
			"nombre": "Ella",
			"texto": "Ahí está el minuto de nuevo.",
			"expresion": "neutral",
			"mostrar_reloj": true,
			"espera": 0.9
		},
		{
			"nombre": "Ella",
			"texto": "A ver qué haces esta vez.",
			"expresion": "coqueta",
			"espera": 1.2
		}
	]


func intro_replay_3() -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": "Tercera vez.",
			"expresion": "sorprendida",
			"espera": 0.9
		},
		{
			"nombre": "Ella",
			"texto": "¿Vienes seguido por aquí?",
			"expresion": "coqueta",
			"espera": 1.2
		},
		{
			"nombre": "Ella",
			"texto": "Es broma.",
			"expresion": "neutral",
			"espera": 0.8
		},
		{
			"nombre": "Ella",
			"texto": "Sé que sí.",
			"expresion": "molesta",
			"espera": 0.9
		},
		{
			"nombre": "Ella",
			"texto": "Ahí está tu minuto otra vez.",
			"expresion": "neutral",
			"mostrar_reloj": true,
			"espera": 0.9
		},
		{
			"nombre": "Ella",
			"texto": "Sorpréndeme.",
			"expresion": "coqueta",
			"espera": 1.0
		}
	]


# Para las repeticiones 4 a 9: texto genérico pero que
# menciona el número real de partidas.
func intro_replay_generica(num: int) -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": "Van " + str(num) + " veces.",
			"expresion": "confundida",
			"espera": 1.0
		},
		{
			"nombre": "Ella",
			"texto": "A este ritmo vamos a terminar viviendo juntos.",
			"expresion": "coqueta",
			"espera": 1.4
		},
		{
			"nombre": "Ella",
			"texto": "Bueno.",
			"expresion": "neutral",
			"espera": 0.7
		},
		{
			"nombre": "Ella",
			"texto": "Ahí está tu minuto.",
			"expresion": "neutral",
			"mostrar_reloj": true,
			"espera": 0.9
		},
		{
			"nombre": "Ella",
			"texto": "Otra vez.",
			"expresion": "coqueta",
			"espera": 0.9
		}
	]


# Desde la partida número 10 en adelante: intro corta,
# vamos directo al grano.
func intro_replay_corta() -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": "Tú de nuevo.",
			"expresion": "neutral",
			"espera": 0.8
		},
		{
			"nombre": "Ella",
			"texto": "Ya sabes cómo va esto.",
			"expresion": "coqueta",
			"mostrar_reloj": true,
			"espera": 0.9
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

	dialogos_actuales = dialogos_introduccion if progreso["partidas_jugadas"] == 0 else construir_intro_replay()
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

	var tipo_especial: String = dialogo.get("tipo", "")
	var texto_linea: String = dialogo.get("texto", "")

	# El objetivo del reto se calcula justo antes de anunciarlo,
	# con los clics reales que tienes en este momento —
	# no cuando arrancó el bloque.
	match tipo_especial:
		"anuncio_objetivo_inicial":
			clicks_al_anunciar_reto = cantidad_clicks
			objetivo_actual = cantidad_clicks + 10
			texto_linea = "Quiero ver si llegas a " + str(objetivo_actual) + " clics."

		"anuncio_objetivo_siguiente":
			clicks_al_anunciar_reto = cantidad_clicks
			objetivo_actual = calcular_siguiente_objetivo(cantidad_clicks)
			texto_linea = "Esta vez quiero llegar a " + str(objetivo_actual) + "."

	texto.text = texto_linea

	# Mostrar el reloj visualmente puede pasar antes de que
	# arranque la cuenta regresiva real (eso sigue pasando
	# recién en iniciar_minuto()).
	if dialogo.get("mostrar_reloj", false):
		reloj.visible = true
		actualizar_reloj()

	var expresion: String = dialogo.get("expresion", "neutral")
	cambiar_expresion(expresion)

	pregunta_activa = ""

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
	conteo_clicks_habilitado = false

	objetivo_actual = OBJETIVO_INICIAL
	bloque_actual_numero = 1

	reto_anunciado = false
	reto_deadline = -1.0

	# Bug raíz: estas variables nunca se reseteaban entre
	# partidas, así que si jugabas dos veces sin recargar la
	# escena, la ruta de la partida anterior contaminaba la
	# nueva (pistas raras, finales mezclados, etc.)
	respondio_tutorial = false
	ruta_reto_activa = false
	reto_completado = false
	ruta_perdedor = false
	clicks_al_anunciar_reto = 0
	confirmo_que_escucha = false
	ruta_romantica = false
	ruta_cobarde = false
	ruta_zen = false
	ruta_indecisa = false
	romance_bloqueado = false
	ruta_impaciente = false
	clicks_antes_del_minuto = 0

	reloj.visible = true
	actualizar_reloj()

	timer.start()

	cargar_bloque(bloque_1())


func actualizar_reloj() -> void:
	@warning_ignore("integer_division")
	var minutos := tiempo_restante / 60
	var segundos := tiempo_restante % 60

	reloj.text = "%02d:%02d" % [minutos, segundos]


# =========================================================
# CLICS
# El diálogo avanza solo (con los timers). El clic SOLO
# cuenta y SOLO responde preguntas activas.
#
# IMPORTANTE: conteo_clicks_habilitado ahora funciona como
# una "ventana" real. Solo está en true mientras hay un reto
# de verdad en curso (ver decidir_siguiente_bloque). Apenas
# se cumple la meta o se acaba el tiempo del reto, se apaga.
# Así los clics fuera de esas ventanas no cuentan para nada
# ni ensucian el siguiente objetivo.
# =========================================================

func registrar_click() -> void:
	if juego_terminado:
		return

	if not minuto_iniciado:
		registrar_click_antes_del_minuto()
		return

	if not conteo_clicks_habilitado:
		return

	cantidad_clicks += 1
	clicks_bloque += 1

	if contador_clicks.visible:
		contador_clicks.text = "Clics: " + str(cantidad_clicks)

	# Si ya cumpliste el objetivo del reto, no hace falta
	# esperar el resto de la ventana de tiempo. Se bloquean
	# los clics de inmediato para que no sigan sumando de
	# más ni afecten el siguiente tramo.
	if (
		reto_anunciado
		and reto_deadline >= 0.0
		and cantidad_clicks >= objetivo_actual
	):
		reto_anunciado = false
		conteo_clicks_habilitado = false
		esperando_siguiente_tramo = false
		cerrar_bloque(bloque_actual_numero)


# Clics que pasan mientras Ella todavía está en la
# introducción: no muestran contador ni cuentan para ningún
# reto, solo se acumulan en silencio. Si el jugador insiste
# demasiado antes de que empiece el minuto, Ella pierde la
# paciencia y corta la conversación de una.
func registrar_click_antes_del_minuto() -> void:
	if fase_actual != "introduccion":
		return

	clicks_antes_del_minuto += 1

	if clicks_antes_del_minuto >= UMBRAL_IMPACIENCIA:
		activar_final_impaciente()


func _on_avanzar_pressed() -> void:
	registrar_click()

	if pregunta_activa != "":
		responder_pregunta()


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

	# El primer clic del tutorial ("haz clic si me estás
	# escuchando") sigue siendo especial: es tanto la
	# respuesta a la pregunta como el primer clic contado.
	# Lo mismo aplica para el clic que confirma la cita: si el
	# jugador clickea para aceptar, ese clic también es un clic
	# real y debe sumar al contador (antes no contaba, lo que
	# dejaba el total desincronizado con lo que el jugador
	# efectivamente hizo).
	if tipo == "tutorial" or tipo == "cita":
		conteo_clicks_habilitado = true

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

		# El número exacto se calcula justo antes de mostrarlo
		# (ver mostrar_dialogo / "anuncio_objetivo_inicial"),
		# así el jugador no puede cumplirlo antes de que Ella
		# termine de pedirlo. La ventana real de clickeo recién
		# se abre en decidir_siguiente_bloque(), que es donde
		# se vuelve a encender conteo_clicks_habilitado.
		reto_anunciado = true
		reto_deadline = -1.0
		conteo_clicks_habilitado = false

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
				"tipo": "anuncio_objetivo_inicial",
				"expresion": "coqueta",
				"espera": 1.4
			},
			{
				"nombre": "Ella",
				"texto": "Sin trampas.",
				"expresion": "molesta",
				"espera": 1.0
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
		conteo_clicks_habilitado = false

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
				"texto": "Tengo una pregunta.",
				"expresion": "sonrojada",
				"espera": 1.1
			},
			{
				"nombre": "Ella",
				"texto": "Haz clic si aceptarías una cita conmigo.",
				"expresion": "sonrojada",
				"pregunta": "cita",
				"ventana": 4.0
			}
		])

	else:
		confirmo_que_escucha = false
		ruta_indecisa = true

		# A partir de acá los clics sí cuentan otra vez: si el
		# jugador sigue clickeando sin que se le esté preguntando
		# nada, eso es justo el gesto "maleducado" que describe
		# el final de ruta_indecisa con más de un clic.
		conteo_clicks_habilitado = true

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

		# A partir de acá el minuto deja de importar: la ruta
		# ya quedó resuelta con esta respuesta. Se congela el
		# reloj (para que no siga corriendo ni corte el diálogo
		# a la mitad) y se oculta, para reforzar que el
		# experimento del minuto ya terminó y ahora solo queda
		# la conversación. decidir_siguiente_bloque() se encarga
		# de esperar a que termine todo el diálogo antes de
		# llamar a terminar_minuto().
		timer.stop()
		reloj.visible = false

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

		# Misma lógica que en la ruta romántica: la respuesta
		# (o la falta de ella) ya definió el final, así que el
		# reloj se congela y se oculta para que el diálogo se
		# vea completo sin que el minuto lo corte.
		timer.stop()
		reloj.visible = false

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

	if reto_anunciado and reto_deadline >= 0.0:
		var ahora := Time.get_ticks_msec() / 1000.0

		if ahora >= reto_deadline:
			reto_anunciado = false
			conteo_clicks_habilitado = false
			esperando_siguiente_tramo = false
			cerrar_bloque(bloque_actual_numero)

	elif esperando_siguiente_tramo:
		var transcurrido := TIEMPO_TOTAL - tiempo_restante

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
	if juego_terminado:
		return

	# Romántica y cobarde ya no dependen del reloj ni del reto:
	# la ruta quedó resuelta apenas el jugador respondió (o no)
	# la pregunta de la cita (ver resolver_cita, donde además se
	# congela y oculta el reloj). No importa en qué bloque estemos
	# ni cuánto tiempo quede: apenas termina de mostrarse todo el
	# diálogo insertado, se cierra el minuto directamente, sin
	# esperar al cronómetro y sin riesgo de que se corte a mitad
	# de camino.
	if ruta_romantica or ruta_cobarde:
		terminar_minuto()
		return

	if reto_anunciado:
		# Si ya cumpliste el objetivo mientras Ella todavía
		# hablaba, no hace falta esperar toda la ventana.
		if cantidad_clicks >= objetivo_actual:
			reto_anunciado = false
			reto_deadline = -1.0
			conteo_clicks_habilitado = false
			cerrar_bloque(bloque_actual_numero)
			return

		# La ventana de clickeo arranca recién cuando termina
		# de mostrarse el diálogo del reto, no antes. Es acá
		# donde se vuelve a habilitar el conteo de clics: es
		# el único momento en que clickear cuenta de verdad.
		if reto_deadline < 0.0:
			reto_deadline = Time.get_ticks_msec() / 1000.0 + VENTANA_RETO
			conteo_clicks_habilitado = true

		esperar_siguiente_tramo()
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
	conteo_clicks_habilitado = false

	if numero == 1:
		if cantidad_clicks >= objetivo_actual and not romance_bloqueado:
			# Ruta principal: aceptó el reto de verdad.
			ruta_reto_activa = true
			romance_bloqueado = true

			# El número del segundo objetivo se calcula al
			# mostrar la línea "anuncio_objetivo_siguiente"
			# dentro de bloque_2_reto(), no acá. La ventana de
			# clickeo se vuelve a abrir en decidir_siguiente_bloque().
			reto_anunciado = true
			reto_deadline = -1.0

			clicks_bloque = 0
			bloque_actual_numero = 2

			cargar_bloque(bloque_2_reto())
		else:
			# No llegó al objetivo. Hay dos casos bien distintos:
			reto_anunciado = false
			reto_deadline = -1.0

			clicks_bloque = 0
			bloque_actual_numero = 2

			if not respondio_tutorial:
				# Nunca respondió ni el primer clic del tutorial:
				# jamás aceptó ningún reto, así que va directo a
				# su propia ruta zen, sin más preguntas.
				ruta_zen = true
				cargar_bloque(bloque_2_zen())
			elif cantidad_clicks > clicks_al_anunciar_reto:
				# Sí aceptó el reto (siguió clickeando después de
				# que se lo pidieron), pero no le alcanzó. Esto es
				# perder el reto, no una ruta secreta.
				ruta_perdedor = true
				romance_bloqueado = true
				cargar_bloque(bloque_2_perdedor())
			else:
				# Respondió el tutorial pero no volvió a clickear
				# ni una vez: nunca aceptó el reto en la práctica,
				# así que todavía puede desviarse a la ruta
				# romántica o caer en zen.
				cargar_bloque(bloque_2_intento_fallido())

	elif numero == 2:
		if ruta_reto_activa:
			reto_completado = cantidad_clicks >= objetivo_actual

			if not reto_completado:
				ruta_perdedor = true

		reto_anunciado = false
		reto_deadline = -1.0

		clicks_bloque = 0
		bloque_actual_numero = 3

		# Si cumplió el reto final, se le suelta la mano: puede
		# seguir clickeando libremente el resto del tiempo, sin
		# meta ni ventana (solo por diversión / easter eggs). Si
		# perdió, queda bloqueado — ver ruta_perdedor en
		# bloque_3_final().
		if ruta_reto_activa and reto_completado:
			conteo_clicks_habilitado = true

		cargar_bloque(bloque_3_final())


func calcular_siguiente_objetivo(clicks_actuales: int) -> int:
	var doble := clicks_actuales * 2
	var mas_veinte := clicks_actuales + 20
	var minimo_seguro := objetivo_actual + 10

	return max(doble, max(mas_veinte, minimo_seguro))


# =========================================================
# BLOQUE 1 — TUTORIAL
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
			"ventana": 5.0
		}
	]


# =========================================================
# BLOQUE 2 — RETO ACEPTADO
# =========================================================

func bloque_2_reto() -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": "Oh.",
			"expresion": "sorprendida",
			"espera": 0.8
		},
		{
			"nombre": "Ella",
			"texto": "Cumpliste el reto.",
			"expresion": "coqueta",
			"espera": 1.1
		},
		{
			"nombre": "Ella",
			"texto": "Vamos a subir la apuesta.",
			"expresion": "molesta",
			"espera": 1.2
		},
		{
			"nombre": "Ella",
			"tipo": "anuncio_objetivo_siguiente",
			"expresion": "coqueta",
			"espera": 1.4
		},
		{
			"nombre": "Ella",
			"texto": "Y esta vez no te me relajes.",
			"expresion": "molesta",
			"espera": 1.1
		}
	]


# =========================================================
# BLOQUE 2 — SILENCIO TOTAL (ni siquiera respondió el tutorial)
# Ruta zen: corre sola, sin más preguntas ni clics.
# =========================================================

func bloque_2_zen() -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": "Ni un clic.",
			"expresion": "confundida",
			"espera": 1.1
		},
		{
			"nombre": "Ella",
			"texto": "Ni siquiera el primero.",
			"expresion": "neutral",
			"espera": 1.2
		},
		{
			"nombre": "Ella",
			"texto": "Está bien.",
			"expresion": "coqueta",
			"espera": 1.0
		},
		{
			"nombre": "Ella",
			"texto": "De hecho, creo que ya ni podrías hacer clic aunque quisieras.",
			"expresion": "confundida",
			"espera": 1.6
		},
		{
			"nombre": "Ella",
			"texto": "Entraste en un estado zen tan profundo que se te olvidó cómo funcionan los dedos.",
			"expresion": "coqueta",
			"espera": 1.9
		},
		{
			"nombre": "Ella",
			"texto": "Voy a hablar sola entonces.",
			"expresion": "confundida",
			"espera": 1.3
		},
		{
			"nombre": "Ella",
			"texto": "Se me da bien.",
			"expresion": "coqueta",
			"espera": 1.1
		}
	]


# =========================================================
# BLOQUE 2 — INTENTO FALLIDO (respondió el tutorial pero
# nunca volvió a clickear: no llegó a aceptar el reto)
# =========================================================

func bloque_2_intento_fallido() -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": "Hm.",
			"expresion": "neutral",
			"espera": 0.9
		},
		{
			"nombre": "Ella",
			"texto": "Ni lo intentaste.",
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
			"texto": "A ver.",
			"expresion": "neutral",
			"espera": 0.8
		},
		{
			"nombre": "Ella",
			"texto": "Haz clic si sigues ahí.",
			"expresion": "coqueta",
			"pregunta": "sigues_ahi",
			"ventana": 5.0
		}
	]


# =========================================================
# BLOQUE 2 — PERDEDOR (aceptó el reto, siguió clickeando,
# pero no le alcanzó para llegar al objetivo)
# =========================================================

func bloque_2_perdedor() -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": "Vaya.",
			"expresion": "sorprendida",
			"espera": 0.9
		},
		{
			"nombre": "Ella",
			"texto": "Sí que lo intentaste.",
			"expresion": "confundida",
			"espera": 1.1
		},
		{
			"nombre": "Ella",
			"texto": "Pero no te alcanzó.",
			"expresion": "molesta",
			"espera": 1.1
		},
		{
			"nombre": "Ella",
			"texto": "Qué vergüenza, la verdad.",
			"expresion": "coqueta",
			"espera": 1.2
		}
	]


# =========================================================
# BLOQUE 3
# =========================================================

func bloque_3_final() -> Array:
	# Romántica y cobarde: la ruta ya quedó resuelta apenas
	# se respondió (o no) la pregunta de la cita. No hay
	# filler que mostrar acá — se va directo a
	# decidir_siguiente_bloque(), que para estas rutas cierra
	# el minuto de inmediato (ver más arriba). Esto evita
	# repetir el mismo sentimiento dos veces ("Ya dije lo que
	# tenía que decir" seguido de "Ya tienes mi respuesta").
	if ruta_romantica or ruta_cobarde:
		return []

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

	if ruta_indecisa:
		return [
			{
				"nombre": "Ella",
				"texto": "Bueno.",
				"expresion": "neutral",
				"espera": 1.0
			},
			{
				"nombre": "Ella",
				"texto": "Ya veremos cómo termina esto.",
				"expresion": "confundida",
				"espera": 1.2
			}
		]

	# CORREGIDO: antes esto se activaba con solo "ruta_reto_activa",
	# lo que hacía que el jugador recibiera "métele caña" incluso
	# cuando ya había perdido el segundo reto (ruta_reto_activa y
	# ruta_perdedor pueden ser true al mismo tiempo). Ahora depende
	# también de reto_completado, y el caso de haber perdido se
	# maneja aparte, sin dar señales de que todavía hay esperanza.
	if ruta_reto_activa and reto_completado:
		return [
			{
				"nombre": "Ella",
				"texto": str(cantidad_clicks) + " clics y contando.",
				"expresion": "confundida",
				"espera": 1.2
			},
			{
				"nombre": "Ella",
				"texto": "Cumpliste el reto.",
				"expresion": "coqueta",
				"espera": 1.0
			},
			{
				"nombre": "Ella",
				"texto": "Sigue si quieres. No te voy a decir que pares.",
				"expresion": "molesta",
				"espera": 1.6
			}
		]

	if ruta_perdedor:
		return [
			{
				"nombre": "Ella",
				"texto": str(cantidad_clicks) + " clics.",
				"expresion": "neutral",
				"espera": 1.1
			},
			{
				"nombre": "Ella",
				"texto": "No llegaste.",
				"expresion": "molesta",
				"espera": 1.0
			},
			{
				"nombre": "Ella",
				"texto": "Ya no hay mucho más que hacer al respecto.",
				"expresion": "confundida",
				"espera": 1.3
			}
		]

	return []


# =========================================================
# RUTA IMPACIENTE (antes de que empiece el minuto)
# =========================================================

func activar_final_impaciente() -> void:
	if juego_terminado:
		return

	ruta_impaciente = true
	juego_terminado = true
	minuto_iniciado = false
	fase_actual = "final"

	timer.stop()
	timer_texto.stop()
	timer_auto_avance.stop()

	escribiendo = false
	pregunta_activa = ""
	pregunta_token += 1

	# Esta ruta nunca llega a terminar_minuto(), así que el
	# progreso se actualiza y guarda acá mismo.
	progreso["partidas_jugadas"] += 1
	progreso["vio_impaciente"] = true
	guardar_progreso()

	cargar_bloque(bloque_impaciente())


func bloque_impaciente() -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": "...",
			"expresion": "molesta",
			"espera": 0.8
		},
		{
			"nombre": "Ella",
			"texto": "¿En serio?",
			"expresion": "molesta",
			"espera": 1.0
		},
		{
			"nombre": "Ella",
			"texto": "Ni siquiera ha empezado el minuto.",
			"expresion": "confundida",
			"espera": 1.3
		},
		{
			"nombre": "Ella",
			"texto": "Y ya estás desesperado por hacer clic.",
			"expresion": "molesta",
			"espera": 1.4
		},
		{
			"nombre": "Ella",
			"texto": "No, gracias.",
			"expresion": "molesta",
			"espera": 1.0
		},
		{
			"nombre": "Ella",
			"texto": "Ponlo en tu currículum: impaciencia crónica.",
			"expresion": "confundida",
			"espera": 1.6
		},
		{
			"nombre": "Ella",
			"texto": "Búscate a otra.",
			"expresion": "ojos_cerrados",
			"espera": 1.3
		}
	]


# =========================================================
# FINAL
# =========================================================

func terminar_minuto() -> void:
	juego_terminado = true
	minuto_iniciado = false

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


# Prioridad de finales: romántica > cobarde > zen > indecisa
# > número especial > rabia > reto completado > reto
# incompleto > normal. Los números especiales van después de
# las rutas narrativas para no pisarlas (ej: romántica con
# 69 clics debe seguir siendo el final romántico).
func construir_cuerpo_final() -> Array:
	var final_especial := obtener_final_numero_especial()
#final ruta romantica
	if ruta_romantica:
		return [
			{
				"nombre": "Ella",
				"texto": "Bueno.",
				"expresion": "coqueta",
				"espera": 1.0
			},
			{
				"nombre": "Ella",
				"texto": "Ya sabes que si te llegara a ver de nuevo... no te diría que no.",
				"expresion": "sonrojada",
				"espera": 1.8
			},
			{
				"nombre": "Ella",
				"texto": "No la vayas a desperdiciar.",
				"expresion": "molesta",
				"espera": 1.3
			},
			{
				"nombre": "Ella",
				"texto": "Nos vemos pronto, espero.",
				"expresion": "sonrojada",
				"espera": 1.3
			}
		]
#final ruta cobarde
	elif ruta_cobarde:
		return [
			{
				"nombre": "Ella",
				"texto": "Bueno.",
				"expresion": "neutral",
				"espera": 1.0
			},
			{
				"nombre": "Ella",
				"texto": "Ya sabes lo que dejaste pasar.",
				"expresion": "coqueta",
				"espera": 1.4
			},
			{
				"nombre": "Ella",
				"texto": "La próxima, no lo pienses tanto.",
				"expresion": "neutral",
				"espera": 1.3
			},
			{
				"nombre": "Ella",
				"texto": "O sí. Tú sabrás.",
				"expresion": "coqueta",
				"espera": 1.1
			}
		]
#final ruta zen
	elif ruta_zen:
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
			},
			{
				"nombre": "Ella",
				"texto": "A veces no intentar también es una decisión.",
				"expresion": "confundida",
				"espera": 1.6
			},
			{
				"nombre": "Ella",
				"texto": "Filosóficamente hablando, claro.",
				"expresion": "coqueta",
				"espera": 1.3
			}
		]
#final ruta indecisa con 1 click
	elif ruta_indecisa and cantidad_clicks <= 1:
		return [
			{
				"nombre": "Ella",
				"texto": "Un clic.",
				"expresion": "confundida",
				"espera": 1.0
			},
			{
				"nombre": "Ella",
				"texto": "Uno solo.",
				"expresion": "coqueta",
				"espera": 0.9
			},
			{
				"nombre": "Ella",
				"texto": "Y después nada.",
				"expresion": "neutral",
				"espera": 1.1
			},
			{
				"nombre": "Ella",
				"texto": "Comprometido hasta cierto punto, ¿no?",
				"expresion": "molesta",
				"espera": 1.5
			}
		]
#final ruta indecisa varios clicks
	elif ruta_indecisa:
		return [
			{
				"nombre": "Ella",
				"texto": str(cantidad_clicks) + " clics, pero a tu manera.",
				"expresion": "confundida",
				"espera": 1.3
			},
			{
				"nombre": "Ella",
				"texto": "Ignoraste mi pregunta...",
				"expresion": "molesta",
				"espera": 1.2
			},
			{
				"nombre": "Ella",
				"texto": "pero seguiste clickeando igual.",
				"expresion": "coqueta",
				"espera": 1.3
			},
			{
				"nombre": "Ella",
				"texto": "Qué maleducado.",
				"expresion": "molesta",
				"espera": 1.0
			}
		]

	elif not final_especial.is_empty():
		return final_especial
#final reto completado
	elif ruta_reto_activa and reto_completado:
		return [
			{
				"nombre": "Ella",
				"texto": str(cantidad_clicks) + " clics en total.",
				"expresion": "molesta",
				"espera": 1.2
			},
			{
				"nombre": "Ella",
				"texto": "Cumpliste el reto.",
				"expresion": "confundida",
				"espera": 1.1
			},
			{
				"nombre": "Ella",
				"texto": "Dedicación, buena puntería y nada de vida social.",
				"expresion": "confundida",
				"espera": 1.5
			},
			{
				"nombre": "Ella",
				"texto": "Un currículum interesante, la verdad.",
				"expresion": "coqueta",
				"espera": 1.4
			},
			{
				"nombre": "Ella",
				"texto": "Ojalá le pusieras esa dedicación a otras cosas.",
				"expresion": "coqueta",
				"espera": 1.5
			}
		]
#final ruta perdedor
	elif ruta_perdedor:
		if ruta_reto_activa:
			# Perdió en el segundo tramo, después de haber
			# pasado el primero.
			return [
				{
					"nombre": "Ella",
					"texto": str(cantidad_clicks) + " clics.",
					"expresion": "neutral",
					"espera": 1.1
				},
				{
					"nombre": "Ella",
					"texto": "Tan cerca.",
					"expresion": "confundida",
					"espera": 1.0
				},
				{
					"nombre": "Ella",
					"texto": "Y aun así, no llegaste.",
					"expresion": "molesta",
					"espera": 1.3
				}
			]
		else:
			# Perdió directamente en el primer tramo.
			return [
				{
					"nombre": "Ella",
					"texto": str(cantidad_clicks) + " clics.",
					"expresion": "neutral",
					"espera": 1.1
				},
				{
					"nombre": "Ella",
					"texto": "Aceptaste el reto...",
					"expresion": "confundida",
					"espera": 1.1
				},
				{
					"nombre": "Ella",
					"texto": "y lo perdiste.",
					"expresion": "molesta",
					"espera": 1.0
				},
				{
					"nombre": "Ella",
					"texto": "Ni siquiera te pedí tanto.",
					"expresion": "coqueta",
					"espera": 1.3
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


# =========================================================
# EASTER EGGS POR NÚMERO DE CLICS
# =========================================================

func obtener_final_numero_especial() -> Array:
	match cantidad_clicks:
		42:
			return [
				{
					"nombre": "Ella",
					"texto": "42 clics.",
					"expresion": "confundida",
					"espera": 1.0
				},
				{
					"nombre": "Ella",
					"texto": "La respuesta a la vida, el universo y todo lo demás.",
					"expresion": "coqueta",
					"espera": 1.7
				},
				{
					"nombre": "Ella",
					"texto": "Qué nerd.",
					"expresion": "molesta",
					"espera": 1.0
				}
			]

		67:
			return [
				{
					"nombre": "Ella",
					"texto": "¿67 clics?",
					"expresion": "molesta",
					"espera": 1.0
				},
				{
					"nombre": "Ella",
					"texto": "¿Te crees chistosito?",
					"expresion": "molesta",
					"espera": 1.2
				},
				{
					"nombre": "Ella",
					"texto": "No entiendo este tipo de humor.",
					"expresion": "confundida",
					"espera": 1.3
				},
				{
					"nombre": "Ella",
					"texto": "Y esta broma va a envejecer mal.",
					"expresion": "neutral",
					"espera": 1.3
				}
			]

		69:
			return [
				{
					"nombre": "Ella",
					"texto": "69 clics.",
					"expresion": "confundida",
					"espera": 1.0
				},
				{
					"nombre": "Ella",
					"texto": "Qué madurez.",
					"expresion": "molesta",
					"espera": 1.1
				},
				{
					"nombre": "Ella",
					"texto": "Ni siquiera lo hiciste a propósito, ¿verdad?",
					"expresion": "coqueta",
					"espera": 1.4
				},
				{
					"nombre": "Ella",
					"texto": "...",
					"expresion": "neutral",
					"espera": 0.8
				},
				{
					"nombre": "Ella",
					"texto": "Sí lo hiciste.",
					"expresion": "coqueta",
					"espera": 1.0
				}
			]

		77:
			return [
				{
					"nombre": "Ella",
					"texto": "77 clics.",
					"expresion": "confundida",
					"espera": 1.0
				},
				{
					"nombre": "Ella",
					"texto": "Número random elegido con mucho compromiso.",
					"expresion": "coqueta",
					"espera": 1.4
				}
			]

		100:
			return [
				{
					"nombre": "Ella",
					"texto": "100 clics.",
					"expresion": "sorprendida",
					"espera": 1.0
				},
				{
					"nombre": "Ella",
					"texto": "Número redondo.",
					"expresion": "coqueta",
					"espera": 1.0
				},
				{
					"nombre": "Ella",
					"texto": "Te gusta el orden, ¿eh?",
					"expresion": "confundida",
					"espera": 1.2
				}
			]

		111:
			return [
				{
					"nombre": "Ella",
					"texto": "111 clics.",
					"expresion": "confundida",
					"espera": 1.0
				},
				{
					"nombre": "Ella",
					"texto": "Triple uno.",
					"expresion": "sorprendida",
					"espera": 0.9
				},
				{
					"nombre": "Ella",
					"texto": "¿Estás bien?",
					"expresion": "coqueta",
					"espera": 1.1
				}
			]

		130:
			return [
				{
					"nombre": "Ella",
					"texto": "130 clics.",
					"expresion": "sorprendida",
					"espera": 1.0
				},
				{
					"nombre": "Ella",
					"texto": "Ya casi ni sé si esto sigue siendo un juego.",
					"expresion": "coqueta",
					"espera": 1.4
				}
			]

		_:
			return []


func bloque_despedida() -> Array:
	var bloque := [
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
		obtener_linea_pista()
	]

	# Solo si el final de ESTA partida fue "cumpliste el reto"
	# (no aplica a ningún otro final). Se sugiere un número que
	# todavía no hayas alcanzado antes; si ya los viste todos,
	# simplemente no se agrega nada.
	if ruta_reto_activa and reto_completado:
		var disponibles: Array = NUMEROS_ESPECIALES.filter(
			func(n): return not progreso["numeros_especiales_vistos"].has(n)
		)

		if not disponibles.is_empty():
			var numero_sugerido: int = disponibles.pick_random()

			# Si la pista de arriba fue "no clickees nada", esta
			# sugerencia sonaría contradictoria sin una transición.
			if pista_es_no_clickees():
				bloque.append({
					"nombre": "Ella",
					"texto": "O quizás podrías...",
					"expresion": "confundida",
					"espera": 1.0
				})

			bloque.append({
				"nombre": "Ella",
				"texto": (
					"Para la próxima, intenta un número justo. Como "
					+ str(numero_sugerido)
					+ ". Ni uno más, ni uno menos."
				),
				"expresion": "coqueta",
				"espera": 1.9
			})

	bloque.append({
		"nombre": "Ella",
		"texto": "Adiós.",
		"expresion": "ojos_cerrados",
		"espera": 1.0
	})

	return bloque


# =========================================================
# PISTAS
# =========================================================

# Sirve para saber si la pista que se va a mostrar es
# justo la de "no clickees nada" — es el único caso donde
# choca con la sugerencia de número especial, así que ahí
# se agrega una línea puente en bloque_despedida().
func pista_es_no_clickees() -> bool:
	if ruta_zen and not progreso["vio_reto_completado"]:
		return false

	return not progreso["vio_zen"]


func obtener_linea_pista() -> Dictionary:
	# Si esta partida terminó en zen y todavía no completaste
	# el reto, esa es la sugerencia más útil posible: son casi
	# opuestos, así que tiene sentido nudgear justo hacia allá.
	if ruta_zen and not progreso["vio_reto_completado"]:
		return {
			"nombre": "Ella",
			"texto": "La próxima vez, prueba aceptar el reto en vez de ignorarme.",
			"expresion": "coqueta",
			"espera": 1.9
		}

	if not progreso["vio_zen"]:
		return {
			"nombre": "Ella",
			"texto": "La próxima vez, ni un clic. Ni uno.",
			"expresion": "neutral",
			"espera": 1.7
		}

	elif not progreso["vio_romantica"]:
		return {
			"nombre": "Ella",
			"texto": "La próxima, prueba contestar cada vez que te pregunte algo, no solo una vez.",
			"expresion": "sonrojada",
			"espera": 2.0
		}

	elif not progreso["vio_indecisa"]:
		return {
			"nombre": "Ella",
			"texto": "Prueba responder el tutorial, pero después ignórame.",
			"expresion": "coqueta",
			"espera": 1.8
		}

	elif not progreso["vio_impaciente"]:
		return {
			"nombre": "Ella",
			"texto": "La próxima vez, no esperes a que empiece el minuto para clickear como loco.",
			"expresion": "confundida",
			"espera": 1.9
		}

	elif not progreso["vio_reto_completado"]:
		return {
			"nombre": "Ella",
			"texto": "Acepta el reto y no te quedes corto.",
			"expresion": "coqueta",
			"espera": 1.6
		}

	elif not progreso["vio_perdedor"]:
		return {
			"nombre": "Ella",
			"texto": "Acepta el reto, pero no te esfuerces tanto.",
			"expresion": "confundida",
			"espera": 1.7
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

	if ruta_zen:
		progreso["vio_zen"] = true

	if ruta_indecisa:
		progreso["vio_indecisa"] = true

	if ruta_romantica:
		progreso["vio_romantica"] = true

	if ruta_reto_activa and reto_completado:
		progreso["vio_reto_completado"] = true

	if ruta_perdedor:
		progreso["vio_perdedor"] = true

	if cantidad_clicks in NUMEROS_ESPECIALES and not progreso["numeros_especiales_vistos"].has(cantidad_clicks):
		progreso["numeros_especiales_vistos"].append(cantidad_clicks)


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
			"vio_indecisa": false,
			"vio_romantica": false,
			"vio_impaciente": false,
			"vio_reto_completado": false,
			"vio_perdedor": false,
			"partidas_jugadas": 0,
			"numeros_especiales_vistos": []
		}

		if FileAccess.file_exists(SAVE_PATH):
			DirAccess.remove_absolute(
				ProjectSettings.globalize_path(SAVE_PATH)
			)

		print("Progreso reiniciado.")
