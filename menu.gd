extends Control


const JUEGO_PATH := "res://Juego.tscn"
const SAVE_PATH := "user://progreso_1minuto.save"


@onready var subtitulo: Label = $Contenido/Titulos/Subtitulo
@onready var boton_jugar: Button = $Contenido/Botones/BotonJugar
@onready var boton_salir: Button = $Contenido/Botones/BotonSalir


func _ready() -> void:
	subtitulo.text = obtener_subtitulo()

	boton_jugar.pressed.connect(_on_jugar)
	boton_salir.pressed.connect(_on_salir)

	boton_jugar.grab_focus()


func _on_jugar() -> void:
	get_tree().change_scene_to_file(JUEGO_PATH)


func _on_salir() -> void:
	get_tree().quit()


func obtener_subtitulo() -> String:
	var partidas_jugadas := cargar_partidas_jugadas()

	if partidas_jugadas == 0:
		return "Tienes un minuto."

	if partidas_jugadas == 1:
		return "¿Otra vez?"

	if partidas_jugadas == 2:
		return "Volviste."

	if partidas_jugadas <= 5:
		var frases_tempranas := [
			"Solo es un minuto.",
			"¿Y ahora qué vas a intentar?",
			"Pensé que pararías.",
			"Sigues aquí.",
			"Empieza a ser costumbre."
		]

		return frases_tempranas.pick_random()

	var frases_repetidas := [
		"No aprendiste nada, ¿verdad?",
		"Ya sabes cómo funciona.",
		"¿Buscando otro final?",
		"No creo que cambie mucho esta vez.",
		"Yo también tendría curiosidad.",
		"Aún no te rindes.",
		"Pensé que ya habías terminado conmigo."
	]

	return frases_repetidas.pick_random()


func cargar_partidas_jugadas() -> int:
	if not FileAccess.file_exists(SAVE_PATH):
		return 0

	var archivo := FileAccess.open(SAVE_PATH, FileAccess.READ)

	if archivo == null:
		push_warning("No se pudo abrir el archivo de progreso.")
		return 0

	var datos = archivo.get_var()
	archivo.close()

	if typeof(datos) != TYPE_DICTIONARY:
		push_warning("El archivo de progreso no contiene un diccionario.")
		return 0

	return int(datos.get("partidas_jugadas", 0))
