extends Control

@onready var nombre = $CajaDialogo/Nombre
@onready var texto = $CajaDialogo/Texto
@onready var reloj = $Reloj
@onready var timer = $Timer
@onready var timer_texto = $TimerTexto
@onready var timer_auto_avance = $TimerAutoAvance
@onready var chica = $Chica

const SPRITE_BASE = "res://sprites/"
const SPRITE_DEFAULT = "ella_neutral.png"

var indice := 0
var tiempo_restante := 10 # Después lo cambiamos a 60
var escribiendo := false
var minuto_iniciado := false
var juego_terminado := false

var velocidad_texto := 0.03
var tiempo_entre_dialogos := 0.8

var cantidad_clicks := 0
var clicks_rapidos := 0
var spam_detectado := false
var tiempo_ultimo_click := 0.0

var fase_actual := "introduccion"

var dialogos_introduccion = [
	{
		"nombre": "Ella",
		"texto": "¡Ah—!",
		"expresion": "sorprendida",
		"espera": 0.5
	},
	{
		"nombre": "Ella",
		"texto": "Perfecto.",
		"expresion": "molesta",
		"espera": 0.7
	},
	{
		"nombre": "Ella",
		"texto": "Choqué contigo.",
		"expresion": "neutral",
		"espera": 0.7
	},
	{
		"nombre": "Ella",
		"texto": "Voy tarde.",
		"expresion": "neutral",
		"espera": 0.7
	},
	{
		"nombre": "Ella",
		"texto": "Y ahora apareció eso.",
		"expresion": "confundida",
		"espera": 0.8
	},
	{
		"nombre": "Ella",
		"texto": "¿Ves el contador?",
		"expresion": "neutral",
		"espera": 0.8
	},
	{
		"nombre": "Ella",
		"texto": "Tienes un minuto.",
		"expresion": "coqueta",
		"espera": 0.7
	},
	{
		"nombre": "Ella",
		"texto": "Conmigo.",
		"expresion": "coqueta",
		"espera": 0.8
	},
	{
		"nombre": "Ella",
		"texto": "Podría ser peor.",
		"expresion": "neutral",
		"espera": 0.8
	},
	{
		"nombre": "Ella",
		"texto": "Podrías hablar, por ejemplo.",
		"expresion": "coqueta",
		"espera": 1.0
	}
]

var dialogos_conversacion = [
	{
		"nombre": "Ella",
		"texto": "Aunque supongo que hacer clic también cuenta como comunicación.",
		"expresion": "neutral",
		"espera": 1.0
	},
	{
		"nombre": "Ella",
		"texto": "Una bastante limitada.",
		"expresion": "molesta",
		"espera": 0.8
	},
	{
		"nombre": "Ella",
		"texto": "Pero he tenido conversaciones peores.",
		"expresion": "coqueta",
		"espera": 1.0
	},
	{
		"nombre": "Ella",
		"texto": "Un minuto no es nada.",
		"expresion": "neutral",
		"espera": 0.8
	},
	{
		"nombre": "Ella",
		"texto": "Y aun así ya estás decidiendo cómo gastarlo.",
		"expresion": "neutral",
		"espera": 1.0
	},
	{
		"nombre": "Ella",
		"texto": "Aunque supongo que hacer clic también cuenta como comunicación.",
		"expresion": "neutral",
		"espera": 1.0
	},
	{
		"nombre": "Ella",
		"texto": "Una bastante limitada.",
		"expresion": "molesta",
		"espera": 0.8
	},
	{
		"nombre": "Ella",
		"texto": "Pero he tenido conversaciones peores.",
		"expresion": "coqueta",
		"espera": 1.0
	},
	{
		"nombre": "Ella",
		"texto": "Un minuto no es nada.",
		"expresion": "neutral",
		"espera": 0.8
	},
	{
		"nombre": "Ella",
		"texto": "Y aun así ya estás decidiendo cómo gastarlo.",
		"expresion": "neutral",
		"espera": 1.0
	},
	{
		"nombre": "Ella",
		"texto": "Podrías escuchar.",
		"expresion": "neutral",
		"espera": 0.8
	},
	{
		"nombre": "Ella",
		"texto": "Podrías apurarme.",
		"expresion": "molesta",
		"espera": 0.8
	},
	{
		"nombre": "Ella",
		"texto": "O podrías quedarte ahí.",
		"expresion": "neutral",
		"espera": 0.8
	},
	{
		"nombre": "Ella",
		"texto": "Supongo que eso también dice algo de ti.",
		"expresion": "coqueta",
		"espera": 1.0
	}
	
]

var dialogos_actuales = []


func _ready() -> void:
	timer.wait_time = 1.0
	timer_texto.wait_time = velocidad_texto

	reloj.visible = false

	dialogos_actuales = dialogos_introduccion
	mostrar_dialogo()


func mostrar_dialogo() -> void:
	if indice >= dialogos_actuales.size():
		terminar_bloque_dialogos()
		return

	var dialogo = dialogos_actuales[indice]

	nombre.text = dialogo.get("nombre", "Ella")
	texto.text = dialogo.get("texto", "")

	var expresion = dialogo.get("expresion", "neutral")
	cambiar_expresion(expresion)

	texto.visible_characters = 0
	escribiendo = true

	timer_auto_avance.stop()
	timer_texto.start()


func cambiar_expresion(expresion: String) -> void:
	var ruta = SPRITE_BASE + "ella_" + expresion + ".png"
	var ruta_default = SPRITE_BASE + SPRITE_DEFAULT

	if ResourceLoader.exists(ruta):
		chica.texture = load(ruta)
	elif ResourceLoader.exists(ruta_default):
		chica.texture = load(ruta_default)
	else:
		push_warning(
			"No se encontró la expresión '"
			+ expresion
			+ "' ni el sprite neutral."
		)


func terminar_bloque_dialogos() -> void:
	if fase_actual == "introduccion":
		iniciar_minuto()
	elif fase_actual == "conversacion":
		# El diálogo se queda esperando mientras corre el reloj.
		timer_auto_avance.stop()


func iniciar_minuto() -> void:
	fase_actual = "conversacion"
	minuto_iniciado = true
	indice = 0

	reloj.visible = true
	actualizar_reloj()

	timer.start()

	dialogos_actuales = dialogos_conversacion
	mostrar_dialogo()


func actualizar_reloj() -> void:
	reloj.text = "Tiempo: " + str(tiempo_restante)


func avanzar_dialogo() -> void:
	if juego_terminado:
		return

	indice += 1

	if indice < dialogos_actuales.size():
		mostrar_dialogo()
	else:
		terminar_bloque_dialogos()


func registrar_click() -> void:
	if not minuto_iniciado or juego_terminado:
		return

	cantidad_clicks += 1

	var momento_actual = Time.get_ticks_msec() / 1000.0
	var diferencia = momento_actual - tiempo_ultimo_click

	if tiempo_ultimo_click > 0.0 and diferencia < 0.4:
		clicks_rapidos += 1

		if clicks_rapidos >= 5:
			spam_detectado = true
	else:
		clicks_rapidos = 0

	tiempo_ultimo_click = momento_actual


func _on_avanzar_pressed() -> void:
	registrar_click()

	if juego_terminado:
		return

	# Si todavía está escribiendo, el clic completa la frase.
	if escribiendo:
		texto.visible_characters = -1
		escribiendo = false
		timer_texto.stop()

		iniciar_espera_autoavance()
		return

	# Si la frase ya terminó, el clic salta la espera.
	if not timer_auto_avance.is_stopped():
		timer_auto_avance.stop()
		avanzar_dialogo()


func iniciar_espera_autoavance() -> void:
	if juego_terminado:
		return

	var espera = tiempo_entre_dialogos

	if indice < dialogos_actuales.size():
		espera = dialogos_actuales[indice].get(
			"espera",
			tiempo_entre_dialogos
		)

	timer_auto_avance.wait_time = espera
	timer_auto_avance.start()


func _on_timer_texto_timeout() -> void:
	texto.visible_characters += 1

	if texto.visible_characters >= texto.get_total_character_count():
		escribiendo = false
		timer_texto.stop()
		iniciar_espera_autoavance()


func _on_timer_auto_avance_timeout() -> void:
	avanzar_dialogo()


func _on_timer_timeout() -> void:
	if not minuto_iniciado or juego_terminado:
		return

	tiempo_restante -= 1
	actualizar_reloj()

	if tiempo_restante <= 0:
		terminar_minuto()


func terminar_minuto() -> void:
	juego_terminado = true
	minuto_iniciado = false

	timer.stop()
	timer_texto.stop()
	timer_auto_avance.stop()

	escribiendo = false

	nombre.text = "Ella"
	cambiar_expresion("neutral")

	if cantidad_clicks == 0:
		texto.text = "Ni un clic.\n\nDebe ser cómodo dejar que las cosas pasen solas."
	elif spam_detectado:
		cambiar_expresion("molesta")
		texto.text = (
			str(cantidad_clicks)
			+ " clics.\n\nPonlo en tu currículum."
		)
	elif cantidad_clicks <= 3:
		texto.text = "No hiciste mucho.\n\nPero al menos te quedaste."
	else:
		cambiar_expresion("coqueta")
		texto.text = "Se acabó.\n\nPodría haber sido peor."

	texto.visible_characters = -1
