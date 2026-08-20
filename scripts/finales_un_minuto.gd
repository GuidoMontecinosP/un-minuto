class_name FinalesUnMinuto
extends RefCounted


static func romantico() -> Array:
	if IdiomaManager.idioma_actual == "en":
		return FinalesUnMinutoEN.romantico()
	return FinalesUnMinutoES.romantico()


static func cobarde() -> Array:
	if IdiomaManager.idioma_actual == "en":
		return FinalesUnMinutoEN.cobarde()
	return FinalesUnMinutoES.cobarde()


static func zen() -> Array:
	if IdiomaManager.idioma_actual == "en":
		return FinalesUnMinutoEN.zen()
	return FinalesUnMinutoES.zen()


static func indecisa_un_click() -> Array:
	if IdiomaManager.idioma_actual == "en":
		return FinalesUnMinutoEN.indecisa_un_click()
	return FinalesUnMinutoES.indecisa_un_click()


static func indecisa_varios_clicks(cantidad_clicks: int) -> Array:
	if IdiomaManager.idioma_actual == "en":
		return FinalesUnMinutoEN.indecisa_varios_clicks(cantidad_clicks)
	return FinalesUnMinutoES.indecisa_varios_clicks(cantidad_clicks)


static func reto_completado(cantidad_clicks: int) -> Array:
	if IdiomaManager.idioma_actual == "en":
		return FinalesUnMinutoEN.reto_completado(cantidad_clicks)
	return FinalesUnMinutoES.reto_completado(cantidad_clicks)


static func perdedor_segundo_tramo(cantidad_clicks: int) -> Array:
	if IdiomaManager.idioma_actual == "en":
		return FinalesUnMinutoEN.perdedor_segundo_tramo(cantidad_clicks)
	return FinalesUnMinutoES.perdedor_segundo_tramo(cantidad_clicks)


static func perdedor_primer_tramo(cantidad_clicks: int) -> Array:
	if IdiomaManager.idioma_actual == "en":
		return FinalesUnMinutoEN.perdedor_primer_tramo(cantidad_clicks)
	return FinalesUnMinutoES.perdedor_primer_tramo(cantidad_clicks)


static func normal() -> Array:
	if IdiomaManager.idioma_actual == "en":
		return FinalesUnMinutoEN.normal()
	return FinalesUnMinutoES.normal()


static func numero_especial(cantidad_clicks: int) -> Array:
	if IdiomaManager.idioma_actual == "en":
		return FinalesUnMinutoEN.numero_especial(cantidad_clicks)
	return FinalesUnMinutoES.numero_especial(cantidad_clicks)


static func despedida_base() -> Array:
	if IdiomaManager.idioma_actual == "en":
		return FinalesUnMinutoEN.despedida_base()
	return FinalesUnMinutoES.despedida_base()


static func despedida_adios() -> Dictionary:
	if IdiomaManager.idioma_actual == "en":
		return FinalesUnMinutoEN.despedida_adios()
	return FinalesUnMinutoES.despedida_adios()


static func puente_numero_especial() -> Dictionary:
	if IdiomaManager.idioma_actual == "en":
		return FinalesUnMinutoEN.puente_numero_especial()
	return FinalesUnMinutoES.puente_numero_especial()


static func sugerencia_numero(numero: int) -> Dictionary:
	if IdiomaManager.idioma_actual == "en":
		return FinalesUnMinutoEN.sugerencia_numero(numero)
	return FinalesUnMinutoES.sugerencia_numero(numero)


static func pista_reto() -> Dictionary:
	if IdiomaManager.idioma_actual == "en":
		return FinalesUnMinutoEN.pista_reto()
	return FinalesUnMinutoES.pista_reto()


static func pista_zen() -> Dictionary:
	if IdiomaManager.idioma_actual == "en":
		return FinalesUnMinutoEN.pista_zen()
	return FinalesUnMinutoES.pista_zen()


static func pista_romantica() -> Dictionary:
	if IdiomaManager.idioma_actual == "en":
		return FinalesUnMinutoEN.pista_romantica()
	return FinalesUnMinutoES.pista_romantica()


static func pista_indecisa() -> Dictionary:
	if IdiomaManager.idioma_actual == "en":
		return FinalesUnMinutoEN.pista_indecisa()
	return FinalesUnMinutoES.pista_indecisa()


static func pista_impaciente() -> Dictionary:
	if IdiomaManager.idioma_actual == "en":
		return FinalesUnMinutoEN.pista_impaciente()
	return FinalesUnMinutoES.pista_impaciente()


static func pista_reto_completado() -> Dictionary:
	if IdiomaManager.idioma_actual == "en":
		return FinalesUnMinutoEN.pista_reto_completado()
	return FinalesUnMinutoES.pista_reto_completado()


static func pista_perdedor() -> Dictionary:
	if IdiomaManager.idioma_actual == "en":
		return FinalesUnMinutoEN.pista_perdedor()
	return FinalesUnMinutoES.pista_perdedor()


static func pista_generica() -> Dictionary:
	if IdiomaManager.idioma_actual == "en":
		return FinalesUnMinutoEN.pista_generica()
	return FinalesUnMinutoES.pista_generica()
