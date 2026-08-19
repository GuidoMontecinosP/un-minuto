extends Node

const SAVE_PATH := "user://idioma.save"

var idioma_actual: String = "es"


func _ready() -> void:
	cargar_idioma()


func cambiar_idioma(nuevo_idioma: String) -> void:
	if nuevo_idioma != "es" and nuevo_idioma != "en":
		push_warning("Idioma no soportado: " + nuevo_idioma)
		return

	idioma_actual = nuevo_idioma
	guardar_idioma()


func guardar_idioma() -> void:
	var archivo := FileAccess.open(
		SAVE_PATH,
		FileAccess.WRITE
	)

	if archivo == null:
		push_warning("No se pudo guardar el idioma.")
		return

	archivo.store_var(idioma_actual)
	archivo.close()


func cargar_idioma() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		return

	var archivo := FileAccess.open(
		SAVE_PATH,
		FileAccess.READ
	)

	if archivo == null:
		push_warning("No se pudo cargar el idioma.")
		return

	var idioma_guardado = archivo.get_var()
	archivo.close()

	if idioma_guardado == "es" or idioma_guardado == "en":
		idioma_actual = idioma_guardado
