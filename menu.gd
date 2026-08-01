extends Control

@onready var boton_jugar = $Contenido/Botones/BotonJugar
@onready var boton_salir = $Contenido/Botones/BotonSalir


func _ready():
	boton_jugar.pressed.connect(_on_jugar)
	boton_salir.pressed.connect(_on_salir)


func _on_jugar():
	get_tree().change_scene_to_file("res://Juego.tscn")


func _on_salir():
	get_tree().quit()
