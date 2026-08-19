class_name DialogosUnMinuto
extends RefCounted


static func intro_inicial() -> Array:
	if IdiomaManager.idioma_actual == "en":
		return DialogosUnMinutoEN.intro_inicial()
	return DialogosUnMinutoES.intro_inicial()


static func intro_replay_1() -> Array:
	if IdiomaManager.idioma_actual == "en":
		return DialogosUnMinutoEN.intro_replay_1()
	return DialogosUnMinutoES.intro_replay_1()


static func intro_replay_2() -> Array:
	if IdiomaManager.idioma_actual == "en":
		return DialogosUnMinutoEN.intro_replay_2()
	return DialogosUnMinutoES.intro_replay_2()


static func intro_replay_3() -> Array:
	if IdiomaManager.idioma_actual == "en":
		return DialogosUnMinutoEN.intro_replay_3()
	return DialogosUnMinutoES.intro_replay_3()


static func intro_replay_generica(num: int) -> Array:
	if IdiomaManager.idioma_actual == "en":
		return DialogosUnMinutoEN.intro_replay_generica(num)
	return DialogosUnMinutoES.intro_replay_generica(num)


static func intro_replay_corta() -> Array:
	if IdiomaManager.idioma_actual == "en":
		return DialogosUnMinutoEN.intro_replay_corta()
	return DialogosUnMinutoES.intro_replay_corta()


static func bloque_1() -> Array:
	if IdiomaManager.idioma_actual == "en":
		return DialogosUnMinutoEN.bloque_1()
	return DialogosUnMinutoES.bloque_1()


static func bloque_2_reto() -> Array:
	if IdiomaManager.idioma_actual == "en":
		return DialogosUnMinutoEN.bloque_2_reto()
	return DialogosUnMinutoES.bloque_2_reto()


static func bloque_2_zen() -> Array:
	if IdiomaManager.idioma_actual == "en":
		return DialogosUnMinutoEN.bloque_2_zen()
	return DialogosUnMinutoES.bloque_2_zen()


static func bloque_2_intento_fallido() -> Array:
	if IdiomaManager.idioma_actual == "en":
		return DialogosUnMinutoEN.bloque_2_intento_fallido()
	return DialogosUnMinutoES.bloque_2_intento_fallido()


static func bloque_2_perdedor() -> Array:
	if IdiomaManager.idioma_actual == "en":
		return DialogosUnMinutoEN.bloque_2_perdedor()
	return DialogosUnMinutoES.bloque_2_perdedor()


static func bloque_impaciente() -> Array:
	if IdiomaManager.idioma_actual == "en":
		return DialogosUnMinutoEN.bloque_impaciente()
	return DialogosUnMinutoES.bloque_impaciente()


static func respuesta_tutorial_si() -> Array:
	if IdiomaManager.idioma_actual == "en":
		return DialogosUnMinutoEN.respuesta_tutorial_si()
	return DialogosUnMinutoES.respuesta_tutorial_si()


static func respuesta_tutorial_no() -> Array:
	if IdiomaManager.idioma_actual == "en":
		return DialogosUnMinutoEN.respuesta_tutorial_no()
	return DialogosUnMinutoES.respuesta_tutorial_no()


static func respuesta_sigues_ahi_si() -> Array:
	if IdiomaManager.idioma_actual == "en":
		return DialogosUnMinutoEN.respuesta_sigues_ahi_si()
	return DialogosUnMinutoES.respuesta_sigues_ahi_si()


static func respuesta_sigues_ahi_no() -> Array:
	if IdiomaManager.idioma_actual == "en":
		return DialogosUnMinutoEN.respuesta_sigues_ahi_no()
	return DialogosUnMinutoES.respuesta_sigues_ahi_no()


static func respuesta_cita_si() -> Array:
	if IdiomaManager.idioma_actual == "en":
		return DialogosUnMinutoEN.respuesta_cita_si()
	return DialogosUnMinutoES.respuesta_cita_si()


static func respuesta_cita_no() -> Array:
	if IdiomaManager.idioma_actual == "en":
		return DialogosUnMinutoEN.respuesta_cita_no()
	return DialogosUnMinutoES.respuesta_cita_no()


static func bloque_3_zen() -> Array:
	if IdiomaManager.idioma_actual == "en":
		return DialogosUnMinutoEN.bloque_3_zen()
	return DialogosUnMinutoES.bloque_3_zen()


static func bloque_3_indecisa() -> Array:
	if IdiomaManager.idioma_actual == "en":
		return DialogosUnMinutoEN.bloque_3_indecisa()
	return DialogosUnMinutoES.bloque_3_indecisa()


static func bloque_3_reto_completado(cantidad_clicks: int) -> Array:
	if IdiomaManager.idioma_actual == "en":
		return DialogosUnMinutoEN.bloque_3_reto_completado(cantidad_clicks)
	return DialogosUnMinutoES.bloque_3_reto_completado(cantidad_clicks)


static func bloque_3_perdedor(cantidad_clicks: int) -> Array:
	if IdiomaManager.idioma_actual == "en":
		return DialogosUnMinutoEN.bloque_3_perdedor(cantidad_clicks)
	return DialogosUnMinutoES.bloque_3_perdedor(cantidad_clicks)


static func anuncio_objetivo_inicial(objetivo: int) -> String:
	if IdiomaManager.idioma_actual == "en":
		return DialogosUnMinutoEN.anuncio_objetivo_inicial(objetivo)
	return DialogosUnMinutoES.anuncio_objetivo_inicial(objetivo)


static func anuncio_objetivo_siguiente(objetivo: int) -> String:
	if IdiomaManager.idioma_actual == "en":
		return DialogosUnMinutoEN.anuncio_objetivo_siguiente(objetivo)
	return DialogosUnMinutoES.anuncio_objetivo_siguiente(objetivo)
