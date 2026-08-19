class_name FinalesUnMinuto
extends RefCounted


# =========================================================
# FINALES DE RUTA
# =========================================================

static func romantico() -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": "Bueno.",
			"expresion": "coqueta",
			"espera": 1.0
		},
		{
			"nombre": "Ella",
			"texto": "Ya sabes que si te llegara a ver de nuevo... no te diría que no.",
			"expresion": "sonrojada",
			"espera": 1.8
		},
		{
			"nombre": "Ella",
			"texto": "No la vayas a desperdiciar.",
			"expresion": "molesta",
			"espera": 1.3
		},
		{
			"nombre": "Ella",
			"texto": "Nos vemos pronto, espero.",
			"expresion": "sonrojada",
			"espera": 1.3
		}
	]


static func cobarde() -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": "Bueno.",
			"expresion": "neutral",
			"espera": 1.0
		},
		{
			"nombre": "Ella",
			"texto": "Ya sabes lo que dejaste pasar.",
			"expresion": "coqueta",
			"espera": 1.4
		},
		{
			"nombre": "Ella",
			"texto": "La próxima, no lo pienses tanto.",
			"expresion": "neutral",
			"espera": 1.3
		},
		{
			"nombre": "Ella",
			"texto": "O sí. Tú sabrás.",
			"expresion": "coqueta",
			"espera": 1.1
		}
	]


static func zen() -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": "Ni uno.",
			"expresion": "sorprendida",
			"espera": 1.1
		},
		{
			"nombre": "Ella",
			"texto": "Dejaste que todo pasara solo.",
			"expresion": "neutral",
			"espera": 1.5
		},
		{
			"nombre": "Ella",
			"texto": "Debe ser cómodo.",
			"expresion": "confundida",
			"espera": 1.2
		},
		{
			"nombre": "Ella",
			"texto": "O aterrador.",
			"expresion": "coqueta",
			"espera": 1.2
		},
		{
			"nombre": "Ella",
			"texto": "A veces no intentar también es una decisión.",
			"expresion": "confundida",
			"espera": 1.6
		},
		{
			"nombre": "Ella",
			"texto": "Filosóficamente hablando, claro.",
			"expresion": "coqueta",
			"espera": 1.3
		}
	]


static func indecisa_un_click() -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": "Un clic.",
			"expresion": "confundida",
			"espera": 1.0
		},
		{
			"nombre": "Ella",
			"texto": "Uno solo.",
			"expresion": "coqueta",
			"espera": 0.9
		},
		{
			"nombre": "Ella",
			"texto": "Y después nada.",
			"expresion": "neutral",
			"espera": 1.1
		},
		{
			"nombre": "Ella",
			"texto": "Comprometido hasta cierto punto, ¿no?",
			"expresion": "molesta",
			"espera": 1.5
		}
	]


static func indecisa_varios_clicks(cantidad_clicks: int) -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": str(cantidad_clicks) + " clics, pero a tu manera.",
			"expresion": "confundida",
			"espera": 1.3
		},
		{
			"nombre": "Ella",
			"texto": "Ignoraste mi pregunta...",
			"expresion": "molesta",
			"espera": 1.2
		},
		{
			"nombre": "Ella",
			"texto": "pero seguiste clickeando igual.",
			"expresion": "coqueta",
			"espera": 1.3
		},
		{
			"nombre": "Ella",
			"texto": "Qué maleducado.",
			"expresion": "molesta",
			"espera": 1.0
		}
	]


static func reto_completado(cantidad_clicks: int) -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": str(cantidad_clicks) + " clics en total.",
			"expresion": "molesta",
			"espera": 1.2
		},
		{
			"nombre": "Ella",
			"texto": "Cumpliste el reto.",
			"expresion": "confundida",
			"espera": 1.1
		},
		{
			"nombre": "Ella",
			"texto": "Dedicación, buena puntería y nada de vida social.",
			"expresion": "confundida",
			"espera": 1.5
		},
		{
			"nombre": "Ella",
			"texto": "Un currículum interesante, la verdad.",
			"expresion": "coqueta",
			"espera": 1.4
		},
		{
			"nombre": "Ella",
			"texto": "Ojalá le pusieras esa dedicación a otras cosas.",
			"expresion": "coqueta",
			"espera": 1.5
		}
	]


static func perdedor_segundo_tramo(cantidad_clicks: int) -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": str(cantidad_clicks) + " clics.",
			"expresion": "neutral",
			"espera": 1.1
		},
		{
			"nombre": "Ella",
			"texto": "Tan cerca.",
			"expresion": "confundida",
			"espera": 1.0
		},
		{
			"nombre": "Ella",
			"texto": "Y aun así, no llegaste.",
			"expresion": "molesta",
			"espera": 1.3
		}
	]


static func perdedor_primer_tramo(cantidad_clicks: int) -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": str(cantidad_clicks) + " clics.",
			"expresion": "neutral",
			"espera": 1.1
		},
		{
			"nombre": "Ella",
			"texto": "Aceptaste el reto...",
			"expresion": "confundida",
			"espera": 1.1
		},
		{
			"nombre": "Ella",
			"texto": "y lo perdiste.",
			"expresion": "molesta",
			"espera": 1.0
		},
		{
			"nombre": "Ella",
			"texto": "Ni siquiera te pedí tanto.",
			"expresion": "coqueta",
			"espera": 1.3
		}
	]


static func normal() -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": "Eso fue...",
			"expresion": "neutral",
			"espera": 1.0
		},
		{
			"nombre": "Ella",
			"texto": "sorprendentemente normal.",
			"expresion": "confundida",
			"espera": 1.3
		},
		{
			"nombre": "Ella",
			"texto": "No sé si felicitarte.",
			"expresion": "coqueta",
			"espera": 1.3
		},
		{
			"nombre": "Ella",
			"texto": "Así que no lo haré.",
			"expresion": "neutral",
			"espera": 1.1
		}
	]


# =========================================================
# EASTER EGGS POR NÚMERO DE CLICS
# =========================================================

static func numero_especial(cantidad_clicks: int) -> Array:
	match cantidad_clicks:
		42:
			return [
				{
					"nombre": "Ella",
					"texto": "42 clics.",
					"expresion": "confundida",
					"espera": 1.0
				},
				{
					"nombre": "Ella",
					"texto": "La respuesta a la vida, el universo y todo lo demás.",
					"expresion": "coqueta",
					"espera": 1.7
				},
				{
					"nombre": "Ella",
					"texto": "Qué nerd.",
					"expresion": "molesta",
					"espera": 1.0
				}
			]

		67:
			return [
				{
					"nombre": "Ella",
					"texto": "¿67 clics?",
					"expresion": "molesta",
					"espera": 1.0
				},
				{
					"nombre": "Ella",
					"texto": "¿Te crees chistosito?",
					"expresion": "molesta",
					"espera": 1.2
				},
				{
					"nombre": "Ella",
					"texto": "No entiendo este tipo de humor.",
					"expresion": "confundida",
					"espera": 1.3
				},
				{
					"nombre": "Ella",
					"texto": "Y esta broma va a envejecer mal.",
					"expresion": "neutral",
					"espera": 1.3
				}
			]

		69:
			return [
				{
					"nombre": "Ella",
					"texto": "69 clics.",
					"expresion": "confundida",
					"espera": 1.0
				},
				{
					"nombre": "Ella",
					"texto": "Qué madurez.",
					"expresion": "molesta",
					"espera": 1.1
				},
				{
					"nombre": "Ella",
					"texto": "Ni siquiera lo hiciste a propósito, ¿verdad?",
					"expresion": "coqueta",
					"espera": 1.4
				},
				{
					"nombre": "Ella",
					"texto": "...",
					"expresion": "neutral",
					"espera": 0.8
				},
				{
					"nombre": "Ella",
					"texto": "Sí lo hiciste.",
					"expresion": "coqueta",
					"espera": 1.0
				}
			]

		77:
			return [
				{
					"nombre": "Ella",
					"texto": "77 clics.",
					"expresion": "confundida",
					"espera": 1.0
				},
				{
					"nombre": "Ella",
					"texto": "Número random elegido con mucho compromiso.",
					"expresion": "coqueta",
					"espera": 1.4
				}
			]

		100:
			return [
				{
					"nombre": "Ella",
					"texto": "100 clics.",
					"expresion": "sorprendida",
					"espera": 1.0
				},
				{
					"nombre": "Ella",
					"texto": "Número redondo.",
					"expresion": "coqueta",
					"espera": 1.0
				},
				{
					"nombre": "Ella",
					"texto": "Te gusta el orden, ¿eh?",
					"expresion": "confundida",
					"espera": 1.2
				}
			]

		111:
			return [
				{
					"nombre": "Ella",
					"texto": "111 clics.",
					"expresion": "confundida",
					"espera": 1.0
				},
				{
					"nombre": "Ella",
					"texto": "Triple uno.",
					"expresion": "sorprendida",
					"espera": 0.9
				},
				{
					"nombre": "Ella",
					"texto": "¿Estás bien?",
					"expresion": "coqueta",
					"espera": 1.1
				}
			]

		130:
			return [
				{
					"nombre": "Ella",
					"texto": "130 clics.",
					"expresion": "sorprendida",
					"espera": 1.0
				},
				{
					"nombre": "Ella",
					"texto": "Ya casi ni sé si esto sigue siendo un juego.",
					"expresion": "coqueta",
					"espera": 1.4
				}
			]

		_:
			return []

# =========================================================
# DESPEDIDA
# =========================================================

static func despedida_base() -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": "Bueno... me tengo que ir.",
			"expresion": "neutral",
			"espera": 1.2
		},
		{
			"nombre": "Ella",
			"texto": "Voy a llegar tarde.",
			"expresion": "confundida",
			"espera": 1.2
		},
		{
			"nombre": "Ella",
			"texto": "Otra vez.",
			"expresion": "neutral",
			"espera": 1.0
		}
	]


static func despedida_adios() -> Dictionary:
	return {
		"nombre": "Ella",
		"texto": "Adiós.",
		"expresion": "ojos_cerrados",
		"espera": 1.0
	}


static func puente_numero_especial() -> Dictionary:
	return {
		"nombre": "Ella",
		"texto": "O quizás podrías...",
		"expresion": "confundida",
		"espera": 1.0
	}


static func sugerencia_numero(numero: int) -> Dictionary:
	return {
		"nombre": "Ella",
		"texto": (
			"Para la próxima, intenta un número justo. Como "
			+ str(numero)
			+ ". Ni uno más, ni uno menos."
		),
		"expresion": "coqueta",
		"espera": 1.9
	}


# =========================================================
# PISTAS
# =========================================================

static func pista_reto() -> Dictionary:
	return {
		"nombre": "Ella",
		"texto": "La próxima vez, prueba aceptar el reto en vez de ignorarme.",
		"expresion": "coqueta",
		"espera": 1.9
	}


static func pista_zen() -> Dictionary:
	return {
		"nombre": "Ella",
		"texto": "La próxima vez, ni un clic. Ni uno.",
		"expresion": "neutral",
		"espera": 1.7
	}


static func pista_romantica() -> Dictionary:
	return {
		"nombre": "Ella",
		"texto": "La próxima, prueba contestar cada vez que te pregunte algo, no solo una vez.",
		"expresion": "sonrojada",
		"espera": 2.0
	}


static func pista_indecisa() -> Dictionary:
	return {
		"nombre": "Ella",
		"texto": "Prueba responder el tutorial, pero después ignórame.",
		"expresion": "coqueta",
		"espera": 1.8
	}


static func pista_impaciente() -> Dictionary:
	return {
		"nombre": "Ella",
		"texto": "La próxima vez, no esperes a que empiece el minuto para clickear como loco.",
		"expresion": "confundida",
		"espera": 1.9
	}


static func pista_reto_completado() -> Dictionary:
	return {
		"nombre": "Ella",
		"texto": "Acepta el reto y no te quedes corto.",
		"expresion": "coqueta",
		"espera": 1.6
	}


static func pista_perdedor() -> Dictionary:
	return {
		"nombre": "Ella",
		"texto": "Acepta el reto, pero no te esfuerces tanto.",
		"expresion": "confundida",
		"espera": 1.7
	}


static func pista_generica() -> Dictionary:
	return {
		"nombre": "Ella",
		"texto": "Supongo que todavía puedes sorprenderme.",
		"expresion": "coqueta",
		"espera": 1.6
	}
