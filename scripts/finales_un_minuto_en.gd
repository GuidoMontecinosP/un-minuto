class_name FinalesUnMinutoEN
extends RefCounted


# =========================================================
# FINALES DE RUTA
# =========================================================

static func romantico() -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": "Well.",
			"expresion": "coqueta",
			"espera": 1.0
		},
		{
			"nombre": "Ella",
			"texto": "You know, if I ever saw you again... I wouldn't say no.",
			"expresion": "sonrojada",
			"espera": 1.8
		},
		{
			"nombre": "Ella",
			"texto": "Don't waste your chance.",
			"expresion": "molesta",
			"espera": 1.3
		},
		{
			"nombre": "Ella",
			"texto": "See you soon, I hope.",
			"expresion": "sonrojada",
			"espera": 1.3
		}
	]


static func cobarde() -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": "Well.",
			"expresion": "neutral",
			"espera": 1.0
		},
		{
			"nombre": "Ella",
			"texto": "You know what you missed out on.",
			"expresion": "coqueta",
			"espera": 1.4
		},
		{
			"nombre": "Ella",
			"texto": "Next time, don't overthink it.",
			"expresion": "neutral",
			"espera": 1.3
		},
		{
			"nombre": "Ella",
			"texto": "Or do. Your call.",
			"expresion": "coqueta",
			"espera": 1.1
		}
	]


static func zen() -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": "Not even one.",
			"expresion": "sorprendida",
			"espera": 1.1
		},
		{
			"nombre": "Ella",
			"texto": "You just let everything happen on its own.",
			"expresion": "neutral",
			"espera": 1.5
		},
		{
			"nombre": "Ella",
			"texto": "Must be comfortable.",
			"expresion": "confundida",
			"espera": 1.2
		},
		{
			"nombre": "Ella",
			"texto": "Or terrifying.",
			"expresion": "coqueta",
			"espera": 1.2
		},
		{
			"nombre": "Ella",
			"texto": "Sometimes not trying is a choice too.",
			"expresion": "confundida",
			"espera": 1.6
		},
		{
			"nombre": "Ella",
			"texto": "Philosophically speaking, of course.",
			"expresion": "coqueta",
			"espera": 1.3
		}
	]


static func indecisa_un_click() -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": "One click.",
			"expresion": "confundida",
			"espera": 1.0
		},
		{
			"nombre": "Ella",
			"texto": "Just one.",
			"expresion": "coqueta",
			"espera": 0.9
		},
		{
			"nombre": "Ella",
			"texto": "And then nothing.",
			"expresion": "neutral",
			"espera": 1.1
		},
		{
			"nombre": "Ella",
			"texto": "Committed up to a point, huh?",
			"expresion": "molesta",
			"espera": 1.5
		}
	]


static func indecisa_varios_clicks(cantidad_clicks: int) -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": str(cantidad_clicks) + " clicks, but on your own terms.",
			"expresion": "confundida",
			"espera": 1.3
		},
		{
			"nombre": "Ella",
			"texto": "You ignored my question...",
			"expresion": "molesta",
			"espera": 1.2
		},
		{
			"nombre": "Ella",
			"texto": "but you kept clicking anyway.",
			"expresion": "coqueta",
			"espera": 1.3
		},
		{
			"nombre": "Ella",
			"texto": "How rude.",
			"expresion": "molesta",
			"espera": 1.0
		}
	]


static func reto_completado(cantidad_clicks: int) -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": str(cantidad_clicks) + " clicks in total.",
			"expresion": "molesta",
			"espera": 1.2
		},
		{
			"nombre": "Ella",
			"texto": "You completed the challenge.",
			"expresion": "confundida",
			"espera": 1.1
		},
		{
			"nombre": "Ella",
			"texto": "Dedication, good aim, and no social life.",
			"expresion": "confundida",
			"espera": 1.5
		},
		{
			"nombre": "Ella",
			"texto": "Quite the résumé, honestly.",
			"expresion": "coqueta",
			"espera": 1.4
		},
		{
			"nombre": "Ella",
			"texto": "If only you put that much dedication into other things.",
			"expresion": "coqueta",
			"espera": 1.5
		}
	]


static func perdedor_segundo_tramo(cantidad_clicks: int) -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": str(cantidad_clicks) + " clicks.",
			"expresion": "neutral",
			"espera": 1.1
		},
		{
			"nombre": "Ella",
			"texto": "So close.",
			"expresion": "confundida",
			"espera": 1.0
		},
		{
			"nombre": "Ella",
			"texto": "And still, you didn't make it.",
			"expresion": "molesta",
			"espera": 1.3
		}
	]


static func perdedor_primer_tramo(cantidad_clicks: int) -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": str(cantidad_clicks) + " clicks.",
			"expresion": "neutral",
			"espera": 1.1
		},
		{
			"nombre": "Ella",
			"texto": "You accepted the challenge...",
			"expresion": "confundida",
			"espera": 1.1
		},
		{
			"nombre": "Ella",
			"texto": "and you lost.",
			"expresion": "molesta",
			"espera": 1.0
		},
		{
			"nombre": "Ella",
			"texto": "I didn't even ask that much of you.",
			"expresion": "coqueta",
			"espera": 1.3
		}
	]


static func normal() -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": "That was...",
			"expresion": "neutral",
			"espera": 1.0
		},
		{
			"nombre": "Ella",
			"texto": "surprisingly normal.",
			"expresion": "confundida",
			"espera": 1.3
		},
		{
			"nombre": "Ella",
			"texto": "I'm not sure whether to congratulate you.",
			"expresion": "coqueta",
			"espera": 1.3
		},
		{
			"nombre": "Ella",
			"texto": "So I won't.",
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
					"texto": "42 clicks.",
					"expresion": "confundida",
					"espera": 1.0
				},
				{
					"nombre": "Ella",
					"texto": "The answer to life, the universe, and everything.",
					"expresion": "coqueta",
					"espera": 1.7
				},
				{
					"nombre": "Ella",
					"texto": "What a nerd.",
					"expresion": "molesta",
					"espera": 1.0
				}
			]

		67:
			return [
				{
					"nombre": "Ella",
					"texto": "67 clicks?",
					"expresion": "molesta",
					"espera": 1.0
				},
				{
					"nombre": "Ella",
					"texto": "Think you're funny?",
					"expresion": "molesta",
					"espera": 1.2
				},
				{
					"nombre": "Ella",
					"texto": "I don't understand this kind of humor.",
					"expresion": "confundida",
					"espera": 1.3
				},
				{
					"nombre": "Ella",
					"texto": "And this joke is going to age badly.",
					"expresion": "neutral",
					"espera": 1.3
				}
			]

		69:
			return [
				{
					"nombre": "Ella",
					"texto": "69 clicks.",
					"expresion": "confundida",
					"espera": 1.0
				},
				{
					"nombre": "Ella",
					"texto": "How mature.",
					"expresion": "molesta",
					"espera": 1.1
				},
				{
					"nombre": "Ella",
					"texto": "You didn't even do it on purpose, did you?",
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
					"texto": "You did.",
					"expresion": "coqueta",
					"espera": 1.0
				}
			]

		77:
			return [
				{
					"nombre": "Ella",
					"texto": "77 clicks.",
					"expresion": "confundida",
					"espera": 1.0
				},
				{
					"nombre": "Ella",
					"texto": "A random number chosen with great commitment.",
					"expresion": "coqueta",
					"espera": 1.4
				}
			]

		100:
			return [
				{
					"nombre": "Ella",
					"texto": "100 clicks.",
					"expresion": "sorprendida",
					"espera": 1.0
				},
				{
					"nombre": "Ella",
					"texto": "Nice round number.",
					"expresion": "coqueta",
					"espera": 1.0
				},
				{
					"nombre": "Ella",
					"texto": "You like things neat, huh?",
					"expresion": "confundida",
					"espera": 1.2
				}
			]

		111:
			return [
				{
					"nombre": "Ella",
					"texto": "111 clicks.",
					"expresion": "confundida",
					"espera": 1.0
				},
				{
					"nombre": "Ella",
					"texto": "Triple one.",
					"expresion": "sorprendida",
					"espera": 0.9
				},
				{
					"nombre": "Ella",
					"texto": "Are you okay?",
					"expresion": "coqueta",
					"espera": 1.1
				}
			]

		130:
			return [
				{
					"nombre": "Ella",
					"texto": "130 clicks.",
					"expresion": "sorprendida",
					"espera": 1.0
				},
				{
					"nombre": "Ella",
					"texto": "I'm not even sure this is still a game anymore.",
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
			"texto": "Well... I have to go.",
			"expresion": "neutral",
			"espera": 1.2
		},
		{
			"nombre": "Ella",
			"texto": "I'm going to be late.",
			"expresion": "confundida",
			"espera": 1.2
		},
		{
			"nombre": "Ella",
			"texto": "Again.",
			"expresion": "neutral",
			"espera": 1.0
		}
	]


static func despedida_adios() -> Dictionary:
	return {
		"nombre": "Ella",
		"texto": "Goodbye.",
		"expresion": "ojos_cerrados",
		"espera": 1.0
	}


static func puente_numero_especial() -> Dictionary:
	return {
		"nombre": "Ella",
		"texto": "Or maybe you could...",
		"expresion": "confundida",
		"espera": 1.0
	}


static func sugerencia_numero(numero: int) -> Dictionary:
	return {
		"nombre": "Ella",
		"texto": (
			"Next time, try an exact number. Like "
			+ str(numero)
			+ ". Not one more, not one less."
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
		"texto": "Next time, try accepting the challenge instead of ignoring me.",
		"expresion": "coqueta",
		"espera": 1.9
	}


static func pista_zen() -> Dictionary:
	return {
		"nombre": "Ella",
		"texto": "Next time, not a single click. Not one.",
		"expresion": "neutral",
		"espera": 1.7
	}


static func pista_romantica() -> Dictionary:
	return {
		"nombre": "Ella",
		"texto": "Next time, try answering every time I ask you something, not just once.",
		"expresion": "sonrojada",
		"espera": 2.0
	}


static func pista_indecisa() -> Dictionary:
	return {
		"nombre": "Ella",
		"texto": "Try answering the tutorial, then ignore me.",
		"expresion": "coqueta",
		"espera": 1.8
	}


static func pista_impaciente() -> Dictionary:
	return {
		"nombre": "Ella",
		"texto": "Next time, don't start clicking like crazy before the minute even begins.",
		"expresion": "confundida",
		"espera": 1.9
	}


static func pista_reto_completado() -> Dictionary:
	return {
		"nombre": "Ella",
		"texto": "Accept the challenge and don't fall short.",
		"expresion": "coqueta",
		"espera": 1.6
	}


static func pista_perdedor() -> Dictionary:
	return {
		"nombre": "Ella",
		"texto": "Accept the challenge, but don't try so hard.",
		"expresion": "confundida",
		"espera": 1.7
	}


static func pista_generica() -> Dictionary:
	return {
		"nombre": "Ella",
		"texto": "I guess you can still surprise me.",
		"expresion": "coqueta",
		"espera": 1.6
	}
