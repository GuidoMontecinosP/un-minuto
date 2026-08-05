extends Control


const SAVE_PATH := "user://progreso_1minuto.save"
const MENU_PATH := "res://Menu.tscn"


@onready var lista_finales: Label = $CenterContainer/Contenido/ListaFinales
@onready var contador: Label = $CenterContainer/Contenido/Contador
@onready var boton_volver: Button = $CenterContainer/Contenido/BotonVolver


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


func _ready() -> void:
	cargar_progreso()
	mostrar_finales()

	boton_volver.pressed.connect(_on_volver_pressed)
	boton_volver.grab_focus()


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

		if progreso.get(clave, false):
			lineas.append("✓ " + nombre_final)
			descubiertos += 1
		else:
			lineas.append("???")

	lista_finales.text = "\n".join(lineas)
	contador.text = str(descubiertos) + " / " + str(finales.size())


func cargar_progreso() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		return

	var archivo := FileAccess.open(SAVE_PATH, FileAccess.READ)

	if archivo == null:
		return

	var datos = archivo.get_var()
	archivo.close()

	if typeof(datos) != TYPE_DICTIONARY:
		return

	for clave in progreso.keys():
		if datos.has(clave):
			progreso[clave] = datos[clave]


func _on_volver_pressed() -> void:
	get_tree().change_scene_to_file(MENU_PATH)
