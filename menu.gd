extends Control


const JUEGO_PATH := "res://Juego.tscn"
const SAVE_PATH := "user://progreso_1minuto.save"


# =========================================================
# NODOS DEL MENÚ PRINCIPAL
# =========================================================

@onready var contenido_principal: Control = $ContenidoPrincipal
@onready var contenido_finales: Control = $ContenidoFinales

@onready var subtitulo: Label = $ContenidoPrincipal/Titulos/Subtitulo

@onready var boton_jugar: Button = $ContenidoPrincipal/Botones/BotonJugar
@onready var boton_finales: Button = $ContenidoPrincipal/Botones/BotonFinales
@onready var boton_salir: Button = $ContenidoPrincipal/Botones/BotonSalir

# =========================================================
# NODOS DEL MENÚ DE LOS FINALES
# =========================================================
@onready var lista_finales: Label = $ContenidoFinales/Contenido/PanelFinales/ListaFinales
@onready var contador_finales: Label = $ContenidoFinales/Contenido/ContadorFinales
@onready var boton_volver: Button = $ContenidoFinales/Contenido/BotonVolver


# =========================================================
# PROGRESO
# =========================================================

var progreso := {
	"vio_zen": false,
	"vio_indecisa": false,
	"vio_romantica": false,
	"vio_cobarde": false,
	"vio_impaciente": false,
	"vio_reto_completado": false,
	"vio_perdedor": false,
	"partidas_jugadas": 0,
	"numeros_especiales_vistos": []
}


# =========================================================
# INICIO
# =========================================================

func _ready() -> void:
	cargar_progreso()

	contenido_principal.visible = true
	contenido_finales.visible = false

	subtitulo.text = obtener_subtitulo()

	boton_jugar.pressed.connect(_on_jugar_pressed)
	boton_finales.pressed.connect(_on_finales_pressed)
	boton_salir.pressed.connect(_on_salir_pressed)
	boton_volver.pressed.connect(_on_volver_pressed)

	boton_jugar.grab_focus()


# =========================================================
# BOTONES
# =========================================================

func _on_jugar_pressed() -> void:
	var error := get_tree().change_scene_to_file(JUEGO_PATH)

	if error != OK:
		push_error(
			"No se pudo abrir la escena del juego. Código: "
			+ str(error)
		)


func _on_finales_pressed() -> void:
	cargar_progreso()
	mostrar_finales()

	contenido_principal.visible = false
	contenido_finales.visible = true

	boton_volver.grab_focus()


func _on_volver_pressed() -> void:
	contenido_finales.visible = false
	contenido_principal.visible = true

	# Se vuelve a actualizar por si el progreso cambió.
	subtitulo.text = obtener_subtitulo()

	boton_finales.grab_focus()


func _on_salir_pressed() -> void:
	get_tree().quit()


# =========================================================
# SUBTÍTULO DINÁMICO
# =========================================================

func obtener_subtitulo() -> String:
	var partidas_jugadas: int = int(
		progreso.get("partidas_jugadas", 0)
	)

	if partidas_jugadas == 0:
		return "Tienes un minuto"

	if partidas_jugadas == 1:
		return "¿Otra vez?"

	if partidas_jugadas == 2:
		return "Volviste"

	if partidas_jugadas <= 5:
		var frases_tempranas := [
			"Solo es un minuto",
			"¿Y ahora qué vas a intentar?",
			"Pensé que pararías",
			"Sigues aquí",
			"Empieza a ser costumbre"
		]

		return frases_tempranas.pick_random()

	var frases_repetidas := [
		"No aprendiste nada, ¿verdad?",
		"Ya sabes cómo funciona.",
		"¿Buscando otro final?",
		"No creo que cambie mucho esta vez.",
		"Yo también tendría curiosidad.",
		"Aún no te rindes",
		"Pensé que ya habías terminado conmigo."
	]

	return frases_repetidas.pick_random()


# =========================================================
# MENÚ DE FINALES
# =========================================================

func mostrar_finales() -> void:
	var finales := [
		["vio_zen", "Zen"],
		["vio_indecisa", "Indeciso"],
		["vio_romantica", "Romántico"],
		["vio_cobarde", "Cobarde"],
		["vio_impaciente", "Impaciente"],
		["vio_reto_completado", "Reto completado"],
		["vio_perdedor", "Perdedor"]
	]

	var lineas: Array[String] = []
	var descubiertos := 0

	for final in finales:
		var clave: String = final[0]
		var nombre_final: String = final[1]
		var desbloqueado: bool = bool(
			progreso.get(clave, false)
		)

		if desbloqueado:
			lineas.append("✓ " + nombre_final)
			descubiertos += 1
		else:
			lineas.append("???")

	lista_finales.text = "\n".join(lineas)

	contador_finales.text = (
		str(descubiertos)
		+ " / "
		+ str(finales.size())
	)


# =========================================================
# CARGAR PROGRESO
# =========================================================

func cargar_progreso() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		return

	var archivo := FileAccess.open(
		SAVE_PATH,
		FileAccess.READ
	)

	if archivo == null:
		push_warning(
			"No se pudo abrir el archivo de progreso."
		)
		return

	var datos = archivo.get_var()
	archivo.close()

	if typeof(datos) != TYPE_DICTIONARY:
		push_warning(
			"El archivo de progreso no contiene un diccionario."
		)
		return

	for clave in progreso.keys():
		if datos.has(clave):
			progreso[clave] = datos[clave]
