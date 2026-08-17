class_name SaveManager
extends RefCounted


static func guardar(path: String, datos: Dictionary) -> bool:
	var archivo := FileAccess.open(path, FileAccess.WRITE)

	if archivo == null:
		push_warning("No se pudo abrir el archivo de guardado: " + path)
		return false

	archivo.store_var(datos)
	archivo.close()

	return true


static func cargar(path: String, datos_por_defecto: Dictionary) -> Dictionary:
	var resultado := datos_por_defecto.duplicate(true)

	if not FileAccess.file_exists(path):
		return resultado

	var archivo := FileAccess.open(path, FileAccess.READ)

	if archivo == null:
		push_warning("No se pudo abrir el archivo de guardado: " + path)
		return resultado

	var datos = archivo.get_var()
	archivo.close()

	if typeof(datos) != TYPE_DICTIONARY:
		push_warning("El archivo de guardado no contiene un diccionario.")
		return resultado

	for clave in resultado.keys():
		if datos.has(clave):
			resultado[clave] = datos[clave]

	return resultado


static func borrar(path: String) -> bool:
	if not FileAccess.file_exists(path):
		return true

	var error := DirAccess.remove_absolute(
		ProjectSettings.globalize_path(path)
	)

	return error == OK
