extends Control

const JUEGO_PATH := "res://Juego.tscn"
const SAVE_PATH := "user://progreso_1minuto.save"

# =========================================================
# NODOS DEL MENÚ PRINCIPAL
# =========================================================

@onready var contenido_principal: Control = $ContenidoPrincipal
@onready var contenido_finales: Control = $ContenidoFinales
@onready var contenido_idiomas: Control = $ContenidoIdiomas

@onready var titulo: Label = $ContenidoPrincipal/Titulos/Titulo
@onready var subtitulo: Label = $ContenidoPrincipal/Titulos/Subtitulo

@onready var boton_jugar: Button = $ContenidoPrincipal/Botones/BotonJugar
@onready var boton_finales: Button = $ContenidoPrincipal/Botones/BotonFinales
@onready var boton_idioma: Button = $ContenidoPrincipal/Botones/BotonIdioma
@onready var boton_salir: Button = $ContenidoPrincipal/Botones/BotonSalir

# =========================================================
# NODOS DEL MENÚ DE FINALES
# =========================================================

@onready var lista_finales: Label = $ContenidoFinales/Contenido/PanelFinales/ListaFinales
@onready var contador_finales: Label = $ContenidoFinales/Contenido/ContadorFinales
@onready var boton_volver: Button = $ContenidoFinales/Contenido/BotonVolver

@onready var grid_finales: GridContainer = $ContenidoFinales/Contenido/PanelFinales/GridFinales

@onready var final_1: Button = $ContenidoFinales/Contenido/PanelFinales/GridFinales/Final1
@onready var final_2: Button = $ContenidoFinales/Contenido/PanelFinales/GridFinales/Final2
@onready var final_3: Button = $ContenidoFinales/Contenido/PanelFinales/GridFinales/Final3
@onready var final_4: Button = $ContenidoFinales/Contenido/PanelFinales/GridFinales/Final4
@onready var final_5: Button = $ContenidoFinales/Contenido/PanelFinales/GridFinales/Final5
@onready var final_6: Button = $ContenidoFinales/Contenido/PanelFinales/GridFinales/Final6
@onready var final_7: Button = $ContenidoFinales/Contenido/PanelFinales/GridFinales/Final7

# Si tienes un título dentro de ContenidoFinales, deja esta línea.
# Si tu nodo se llama distinto, cambia la ruta.
@onready var titulo_finales: Label = $ContenidoFinales/Contenido/TituloFinales

# =========================================================
# NODOS DEL MENÚ DE IDIOMA
# =========================================================

@onready var titulo_idiomas: Label = $ContenidoIdiomas/Contenido/Idioma

@onready var boton_espanol: Button = $ContenidoIdiomas/Contenido/BotonEspanol
@onready var boton_english: Button = $ContenidoIdiomas/Contenido/BotonEnglish
@onready var boton_volver_idioma: Button = $ContenidoIdiomas/Contenido/BotonVolver

@onready var contenedor_idiomas: BoxContainer = $ContenidoIdiomas/Contenido

# =========================================================
# PROGRESO
# =========================================================

var subtitulo_actual: String = ""

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
	seleccionar_subtitulo()
	
	
	contenido_principal.visible = true
	contenido_finales.visible = false
	contenido_idiomas.visible = false

	boton_jugar.pressed.connect(_on_jugar_pressed)
	boton_finales.pressed.connect(_on_finales_pressed)
	boton_idioma.pressed.connect(_on_idioma_pressed)
	boton_salir.pressed.connect(_on_salir_pressed)

	boton_volver.pressed.connect(_on_volver_pressed)


	actualizar_textos_menu()

	boton_jugar.grab_focus()
	configurar_menu_idiomas()
	
	configurar_menu_finales()

func configurar_menu_finales() -> void:
	var botones_finales := [
		final_1,
		final_2,
		final_3,
		final_4,
		final_5,
		final_6,
		final_7
	]
	grid_finales.position.x += 20
	grid_finales.size.x -= 40

	for boton in botones_finales:
		boton.custom_minimum_size = Vector2(220, 85)
		boton.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
		boton.text_overrun_behavior = TextServer.OVERRUN_TRIM_ELLIPSIS

	grid_finales.add_theme_constant_override(
		"h_separation",
		6
	)

	grid_finales.add_theme_constant_override(
		"v_separation",
		12
	)


	for boton in botones_finales:
		boton.custom_minimum_size = Vector2(200, 85)
		boton.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
		boton.text_overrun_behavior = TextServer.OVERRUN_TRIM_ELLIPSIS

	grid_finales.add_theme_constant_override(
		"h_separation",
		16
	)

	grid_finales.add_theme_constant_override(
		"v_separation",
		14
	)
	

	for boton in botones_finales:
		boton.custom_minimum_size = Vector2(215, 85)

	grid_finales.add_theme_constant_override(
		"h_separation",
		18
	)

	grid_finales.add_theme_constant_override(
		"v_separation",
		14
	)
# =========================================================
# BOTONES PRINCIPALES
# =========================================================
func configurar_menu_idiomas() -> void:
	# Todos los botones tendrán exactamente el mismo ancho.
	var ancho := 500.0

	boton_espanol.custom_minimum_size.x = ancho
	boton_english.custom_minimum_size.x = ancho
	boton_volver_idioma.custom_minimum_size.x = ancho

	# El título también ocupa exactamente ese ancho.
	titulo_idiomas.custom_minimum_size.x = ancho
	titulo_idiomas.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER

	# El contenedor no puede hacerse más angosto.
	contenedor_idiomas.custom_minimum_size.x = ancho
	
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
	contenido_idiomas.visible = false
	contenido_finales.visible = true

	boton_volver.grab_focus()


func _on_idioma_pressed() -> void:
	if IdiomaManager.idioma_actual == "es":
		IdiomaManager.cambiar_idioma("en")
	else:
		IdiomaManager.cambiar_idioma("es")

	actualizar_textos_menu()

func _on_salir_pressed() -> void:
	get_tree().quit()

# =========================================================
# VOLVER DESDE FINALES
# =========================================================

func _on_volver_pressed() -> void:
	contenido_finales.visible = false
	contenido_principal.visible = true


	boton_finales.grab_focus()

# =========================================================
# IDIOMAS
# =========================================================

func _on_espanol_pressed() -> void:
	IdiomaManager.cambiar_idioma("es")
	actualizar_textos_menu()


func _on_english_pressed() -> void:
	IdiomaManager.cambiar_idioma("en")
	actualizar_textos_menu()


func _on_volver_idioma_pressed() -> void:
	contenido_idiomas.visible = false
	contenido_principal.visible = true

	boton_idioma.grab_focus()

# =========================================================
# ACTUALIZAR TEXTOS DEL MENÚ
# =========================================================

func actualizar_textos_menu() -> void:
	if IdiomaManager.idioma_actual == "es":
		titulo.text = "UN MINUTO"

		boton_jugar.text = "Jugar"
		boton_finales.text = "Finales"
		boton_idioma.text = "Idioma: ES"
		boton_salir.text = "Salir"

		titulo_finales.text = "Finales"
		boton_volver.text = "Volver"

	else:
		titulo.text = "ONE MINUTE"

		boton_jugar.text = "Play"
		boton_finales.text = "Endings"
		boton_idioma.text = "Language: EN"
		boton_salir.text = "Quit"

		titulo_finales.text = "Endings"
		boton_volver.text = "Back"

	subtitulo.text = obtener_subtitulo()

	if contenido_finales.visible:
		mostrar_finales()
	if IdiomaManager.idioma_actual == "es":
		titulo.text = "UN MINUTO"

		boton_jugar.text = "Jugar"
		boton_finales.text = "Finales"
		boton_idioma.text = "Idioma"
		boton_salir.text = "Salir"

		titulo_finales.text = "Finales"
		boton_volver.text = "Volver"

		titulo_idiomas.text = "Idioma"

		# Estos dos NO cambian
		boton_espanol.text = "Español"
		boton_english.text = "English"

		boton_volver_idioma.text = "Volver"

	else:
		titulo.text = "ONE MINUTE"

		boton_jugar.text = "Play"
		boton_finales.text = "Endings"
		boton_idioma.text = "Language"
		boton_salir.text = "Quit"

		titulo_finales.text = "Endings"
		boton_volver.text = "Back"

		titulo_idiomas.text = "Language"

		# EXACTAMENTE IGUAL
		boton_espanol.text = "Español"
		boton_english.text = "English"

		boton_volver_idioma.text = "Back"

	subtitulo.text = obtener_subtitulo()

	if contenido_finales.visible:
		mostrar_finales()
# =========================================================
# SUBTÍTULO DINÁMICO
# =========================================================

func seleccionar_subtitulo() -> void:
	var partidas_jugadas: int = int(
		progreso.get("partidas_jugadas", 0)
	)

	if partidas_jugadas == 0:
		subtitulo_actual = "primera"
		return

	if partidas_jugadas == 1:
		subtitulo_actual = "otra_vez"
		return

	if partidas_jugadas == 2:
		subtitulo_actual = "volviste"
		return

	if partidas_jugadas <= 5:
		var opciones_tempranas := [
			"solo_minuto",
			"que_intentar",
			"pensaba_pararias",
			"sigues_aqui",
			"costumbre"
		]

		subtitulo_actual = opciones_tempranas.pick_random()
		return

	var opciones_repetidas := [
		"no_aprendiste",
		"ya_sabes",
		"otro_final",
		"no_cambie",
		"curiosidad",
		"no_rindes",
		"terminado"
	]

	subtitulo_actual = opciones_repetidas.pick_random()

func obtener_subtitulo() -> String:
	if IdiomaManager.idioma_actual == "es":
		match subtitulo_actual:
			"primera":
				return "Tienes un minuto"
			"otra_vez":
				return "¿Otra vez?"
			"volviste":
				return "Volviste"
			"solo_minuto":
				return "Solo es un minuto"
			"que_intentar":
				return "¿Y ahora qué vas a intentar?"
			"pensaba_pararias":
				return "Pensé que pararías"
			"sigues_aqui":
				return "Sigues aquí"
			"costumbre":
				return "Empieza a ser costumbre"
			"no_aprendiste":
				return "No aprendiste nada, ¿verdad?"
			"ya_sabes":
				return "Ya sabes cómo funciona."
			"otro_final":
				return "¿Buscando otro final?"
			"no_cambie":
				return "No creo que cambie mucho esta vez."
			"curiosidad":
				return "Yo también tendría curiosidad."
			"no_rindes":
				return "Aún no te rindes"
			"terminado":
				return "Pensé que ya habías terminado conmigo."

	else:
		match subtitulo_actual:
			"primera":
				return "You have one minute"
			"otra_vez":
				return "Again?"
			"volviste":
				return "You're back"
			"solo_minuto":
				return "It's only a minute"
			"que_intentar":
				return "What are you trying this time?"
			"pensaba_pararias":
				return "I thought you'd stop"
			"sigues_aqui":
				return "You're still here"
			"costumbre":
				return "This is becoming a habit"
			"no_aprendiste":
				return "You didn't learn anything, did you?"
			"ya_sabes":
				return "You already know how this works."
			"otro_final":
				return "Looking for another ending?"
			"no_cambie":
				return "I don't think it'll change much this time."
			"curiosidad":
				return "I'd be curious too."
			"no_rindes":
				return "You still haven't given up"
			"terminado":
				return "I thought you were done with me."

	return ""
# =========================================================
# MENÚ DE FINALES
# =========================================================

func mostrar_finales() -> void:
	var botones := [
		final_1,
		final_2,
		final_3,
		final_4,
		final_5,
		final_6,
		final_7
	]

	var finales: Array

	if IdiomaManager.idioma_actual == "es":
		finales = [
			["vio_zen", "Zen"],
			["vio_indecisa", "Indeciso"],
			["vio_romantica", "Romántico"],
			["vio_cobarde", "Cobarde"],
			["vio_impaciente", "Impaciente"],
			["vio_reto_completado", "Reto"],
			["vio_perdedor", "Perdedor"]
		]
	else:
		finales = [
		["vio_zen", "Zen"],
		["vio_indecisa", "Indecisive"],
		["vio_romantica", "Romantic"],
		["vio_cobarde", "Coward"],
		["vio_impaciente", "Impatient"],
		["vio_reto_completado", "Challenge"],
		["vio_perdedor", "Loser"]
	]
	

	var descubiertos := 0

	for i in range(finales.size()):
		var clave: String = finales[i][0]
		var nombre_final: String = finales[i][1]

		var desbloqueado: bool = bool(
			progreso.get(clave, false)
		)

		var numero := "%02d" % (i + 1)

		if desbloqueado:
			botones[i].text = (
				numero
				+ "\n"
				+ nombre_final
			)

			botones[i].disabled = false
			descubiertos += 1

		else:
			botones[i].text = (
				numero
				+ "\n???"
			)

			botones[i].disabled = true

	if IdiomaManager.idioma_actual == "es":
		contador_finales.text = (
			str(descubiertos)
			+ " / "
			+ str(finales.size())

		)
	else:
		contador_finales.text = (
			str(descubiertos)
			+ " / "
			+ str(finales.size())
			+ " discovered"
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
