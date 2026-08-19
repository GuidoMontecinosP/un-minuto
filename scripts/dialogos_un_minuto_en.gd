class_name DialogosUnMinutoEN
extends RefCounted

static func intro_inicial() -> Array: 
	return [
	{
		"nombre": "Ella",
		"texto": "Ah—!",
		"expresion": "sorprendida",
		"espera": 0.6
	},
	{
		"nombre": "Ella",
		"texto": "...",
		"expresion": "molesta",
		"espera": 0.7
	},
	{
		"nombre": "Ella",
		"texto": "Great.",
		"expresion": "molesta",
		"espera": 0.8
	},
	{
		"nombre": "Ella",
		"texto": "I bumped into you.",
		"expresion": "neutral",
		"espera": 0.9
	},
	{
		"nombre": "Ella",
		"texto": "Don't make that face.",
		"expresion": "confundida",
		"espera": 0.9
	},
	{
		"nombre": "Ella",
		"texto": "It was my fault too.",
		"expresion": "neutral",
		"espera": 1.0
	},
	{
		"nombre": "Ella",
		"texto": "I was running late.",
		"expresion": "neutral",
		"espera": 0.8
	},
	{
		"nombre": "Ella",
		"texto": "Now I'm running late with you.",
		"expresion": "coqueta",
		"espera": 1.1
	},
	{
		"nombre": "Ella",
		"texto": "How romantic.",
		"expresion": "coqueta",
		"espera": 1.0
	},
	{
		"nombre": "Ella",
		"texto": "And then that appeared.",
		"expresion": "confundida",
		"mostrar_reloj": true,
		"espera": 0.9
	},
	{
		"nombre": "Ella",
		"texto": "One minute.",
		"expresion": "neutral",
		"espera": 0.9
	},
	{
		"nombre": "Ella",
		"texto": "With me.",
		"expresion": "coqueta",
		"espera": 1.0
	},
	{
		"nombre": "Ella",
		"texto": "Could be worse.",
		"expresion": "neutral",
		"espera": 1.0
	}
]

static func intro_replay_1() -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": "You again?",
			"expresion": "confundida",
			"espera": 0.9
		},
		{
			"nombre": "Ella",
			"texto": "What a coincidence.",
			"expresion": "coqueta",
			"espera": 1.0
		},
		{
			"nombre": "Ella",
			"texto": "Or maybe not.",
			"expresion": "molesta",
			"espera": 0.9
		},
		{
			"nombre": "Ella",
			"texto": "Well.",
			"expresion": "neutral",
			"espera": 0.8
		},
		{
			"nombre": "Ella",
			"texto": "That thing showed up again.",
			"expresion": "confundida",
			"mostrar_reloj": true,
			"espera": 0.9
		},
		{
			"nombre": "Ella",
			"texto": "One minute.",
			"expresion": "neutral",
			"espera": 0.9
		},
		{
			"nombre": "Ella",
			"texto": "With me again.",
			"expresion": "coqueta",
			"espera": 1.0
		},
		{
			"nombre": "Ella",
			"texto": "Let's see if things go differently this time.",
			"expresion": "neutral",
			"espera": 1.3
		}
	]


static func intro_replay_2() -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": "You again.",
			"expresion": "confundida",
			"espera": 0.9
		},
		{
			"nombre": "Ella",
			"texto": "I'm starting to think this isn't a coincidence.",
			"expresion": "coqueta",
			"espera": 1.4
		},
		{
			"nombre": "Ella",
			"texto": "Well, I'm not complaining.",
			"expresion": "sonrojada",
			"espera": 1.1
		},
		{
			"nombre": "Ella",
			"texto": "There's the minute again.",
			"expresion": "neutral",
			"mostrar_reloj": true,
			"espera": 0.9
		},
		{
			"nombre": "Ella",
			"texto": "Let's see what you do this time.",
			"expresion": "coqueta",
			"espera": 1.2
		}
	]


static func intro_replay_3() -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": "Third time.",
			"expresion": "sorprendida",
			"espera": 0.9
		},
		{
			"nombre": "Ella",
			"texto": "Do you come here often?",
			"expresion": "coqueta",
			"espera": 1.2
		},
		{
			"nombre": "Ella",
			"texto": "Just kidding.",
			"expresion": "neutral",
			"espera": 0.8
		},
		{
			"nombre": "Ella",
			"texto": "I know you do.",
			"expresion": "molesta",
			"espera": 0.9
		},
		{
			"nombre": "Ella",
			"texto": "There's your minute again.",
			"expresion": "neutral",
			"mostrar_reloj": true,
			"espera": 0.9
		},
		{
			"nombre": "Ella",
			"texto": "Surprise me.",
			"expresion": "coqueta",
			"espera": 1.0
		}
	]


# Replays 4 to 9: generic text that
# mentions the actual play count.
static func intro_replay_generica(num: int) -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": "That makes " + str(num) + " times.",
			"expresion": "confundida",
			"espera": 1.0
		},
		{
			"nombre": "Ella",
			"texto": "At this rate, we're going to end up living together.",
			"expresion": "coqueta",
			"espera": 1.4
		},
		{
			"nombre": "Ella",
			"texto": "Well.",
			"expresion": "neutral",
			"espera": 0.7
		},
		{
			"nombre": "Ella",
			"texto": "There's your minute.",
			"expresion": "neutral",
			"mostrar_reloj": true,
			"espera": 0.9
		},
		{
			"nombre": "Ella",
			"texto": "Again.",
			"expresion": "coqueta",
			"espera": 0.9
		}
	]


# From playthrough 10 onward: short intro,
# straight to the point.
static func intro_replay_corta() -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": "You again.",
			"expresion": "neutral",
			"espera": 0.8
		},
		{
			"nombre": "Ella",
			"texto": "You know how this goes.",
			"expresion": "coqueta",
			"mostrar_reloj": true,
			"espera": 0.9
		}
	]



# =========================================================
# BLOCK 1 — TUTORIAL
# =========================================================

static func bloque_1() -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": "Well.",
			"expresion": "neutral",
			"espera": 0.9
		},
		{
			"nombre": "Ella",
			"texto": "Looks like you can't talk.",
			"expresion": "confundida",
			"espera": 1.3
		},
		{
			"nombre": "Ella",
			"texto": "Convenient for me.",
			"expresion": "coqueta",
			"espera": 1.1
		},
		{
			"nombre": "Ella",
			"texto": "Let's try something.",
			"expresion": "neutral",
			"espera": 1.0
		},
		{
			"nombre": "Ella",
			"texto": "Click if you're listening to me.",
			"expresion": "coqueta",
			"pregunta": "tutorial",
			"ventana": 5.0
		}
	]


# =========================================================
# BLOCK 2 — CHALLENGE ACCEPTED
# =========================================================

static func bloque_2_reto() -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": "Oh.",
			"expresion": "sorprendida",
			"espera": 0.8
		},
		{
			"nombre": "Ella",
			"texto": "You completed the challenge.",
			"expresion": "coqueta",
			"espera": 1.1
		},
		{
			"nombre": "Ella",
			"texto": "Let's raise the stakes.",
			"expresion": "molesta",
			"espera": 1.2
		},
		{
			"nombre": "Ella",
			"tipo": "anuncio_objetivo_siguiente",
			"expresion": "coqueta",
			"espera": 1.4
		},
		{
			"nombre": "Ella",
			"texto": "And don't slack off this time.",
			"expresion": "molesta",
			"espera": 1.1
		}
	]


# =========================================================
# BLOCK 2 — TOTAL SILENCE (did not even answer the tutorial)
# Zen route: runs on its own, with no more questions or clicks.
# =========================================================

static func bloque_2_zen() -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": "Not a single click.",
			"expresion": "confundida",
			"espera": 1.1
		},
		{
			"nombre": "Ella",
			"texto": "Not even the first one.",
			"expresion": "neutral",
			"espera": 1.2
		},
		{
			"nombre": "Ella",
			"texto": "All right.",
			"expresion": "coqueta",
			"espera": 1.0
		},
		{
			"nombre": "Ella",
			"texto": "Actually, I don't think you could click anymore even if you wanted to.",
			"expresion": "confundida",
			"espera": 1.6
		},
		{
			"nombre": "Ella",
			"texto": "You reached such a deep state of zen that you forgot how fingers work.",
			"expresion": "coqueta",
			"espera": 1.9
		},
		{
			"nombre": "Ella",
			"texto": "Guess I'll talk to myself, then.",
			"expresion": "confundida",
			"espera": 1.3
		},
		{
			"nombre": "Ella",
			"texto": "I'm good at that.",
			"expresion": "coqueta",
			"espera": 1.1
		}
	]


# =========================================================
# BLOCK 2 — FAILED ATTEMPT (answered the tutorial but
# never clicked again: did not actually accept the challenge)
# =========================================================

static func bloque_2_intento_fallido() -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": "Hm.",
			"expresion": "neutral",
			"espera": 0.9
		},
		{
			"nombre": "Ella",
			"texto": "You didn't even try.",
			"expresion": "confundida",
			"espera": 1.2
		},
		{
			"nombre": "Ella",
			"texto": "Suspiciously sensible.",
			"expresion": "coqueta",
			"espera": 1.3
		},
		{
			"nombre": "Ella",
			"texto": "Let's see.",
			"expresion": "neutral",
			"espera": 0.8
		},
		{
			"nombre": "Ella",
			"texto": "Click if you're still there.",
			"expresion": "coqueta",
			"pregunta": "sigues_ahi",
			"ventana": 5.0
		}
	]


# =========================================================
# BLOCK 2 — LOSER (accepted the challenge, kept clicking,
# but did not reach the target)
# =========================================================

static func bloque_2_perdedor() -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": "Wow.",
			"expresion": "sorprendida",
			"espera": 0.9
		},
		{
			"nombre": "Ella",
			"texto": "You really did try.",
			"expresion": "confundida",
			"espera": 1.1
		},
		{
			"nombre": "Ella",
			"texto": "But it wasn't enough.",
			"expresion": "molesta",
			"espera": 1.1
		},
		{
			"nombre": "Ella",
			"texto": "Pretty embarrassing, honestly.",
			"expresion": "coqueta",
			"espera": 1.2
		}
	]


static func bloque_impaciente() -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": "...",
			"expresion": "molesta",
			"espera": 0.8
		},
		{
			"nombre": "Ella",
			"texto": "Seriously?",
			"expresion": "molesta",
			"espera": 1.0
		},
		{
			"nombre": "Ella",
			"texto": "The minute hasn't even started yet.",
			"expresion": "confundida",
			"espera": 1.3
		},
		{
			"nombre": "Ella",
			"texto": "And you're already desperate to click.",
			"expresion": "molesta",
			"espera": 1.4
		},
		{
			"nombre": "Ella",
			"texto": "No, thanks.",
			"expresion": "molesta",
			"espera": 1.0
		},
		{
			"nombre": "Ella",
			"texto": "Put it on your résumé: chronic impatience.",
			"expresion": "confundida",
			"espera": 1.6
		},
		{
			"nombre": "Ella",
			"texto": "Go find someone else.",
			"expresion": "ojos_cerrados",
			"espera": 1.3
		}
	]


static func respuesta_tutorial_si() -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": "Oh.",
			"expresion": "sorprendida",
			"espera": 0.8
		},
		{
			"nombre": "Ella",
			"texto": "You were listening to me.",
			"expresion": "coqueta",
			"espera": 1.2
		},
		{
			"nombre": "Ella",
			"texto": "How attentive.",
			"expresion": "coqueta",
			"espera": 1.0
		},
		{
			"nombre": "Ella",
			"texto": "So now we have a language.",
			"expresion": "neutral",
			"espera": 1.3
		},
		{
			"nombre": "Ella",
			"texto": "A pretty limited one.",
			"expresion": "confundida",
			"espera": 1.2
		},
		{
			"nombre": "Ella",
			"tipo": "anuncio_objetivo_inicial",
			"expresion": "coqueta",
			"espera": 1.4
		},
		{
			"nombre": "Ella",
			"texto": "No cheating.",
			"expresion": "molesta",
			"espera": 1.0
		},
		{
			"nombre": "Ella",
			"texto": "I dare you.",
			"expresion": "molesta",
			"espera": 1.0
		}
	]


static func respuesta_tutorial_no() -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": "...",
			"expresion": "confundida",
			"espera": 0.9
		},
		{
			"nombre": "Ella",
			"texto": "Well.",
			"expresion": "neutral",
			"espera": 0.9
		},
		{
			"nombre": "Ella",
			"texto": "This is going to be a difficult conversation.",
			"expresion": "coqueta",
			"espera": 1.4
		}
	]


static func respuesta_sigues_ahi_si() -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": "Ah.",
			"expresion": "sorprendida",
			"espera": 0.8
		},
		{
			"nombre": "Ella",
			"texto": "You were listening after all.",
			"expresion": "coqueta",
			"espera": 1.2
		},
		{
			"nombre": "Ella",
			"texto": "Quite the gentleman.",
			"expresion": "coqueta",
			"espera": 1.1
		},
		{
			"nombre": "Ella",
			"texto": "I have a question.",
			"expresion": "sonrojada",
			"espera": 1.1
		},
		{
			"nombre": "Ella",
			"texto": "Click if you'd go on a date with me.",
			"expresion": "sonrojada",
			"pregunta": "cita",
			"ventana": 4.0
		}
	]


static func respuesta_sigues_ahi_no() -> Array:
	
	return [
		{
			"nombre": "Ella",
			"texto": "...",
			"expresion": "confundida",
			"espera": 1.0
		},
		{
			"nombre": "Ella",
			"texto": "Wow.",
			"expresion": "neutral",
			"espera": 0.9
		},
		{
			"nombre": "Ella",
			"texto": "You really are unshakable.",
			"expresion": "coqueta",
			"espera": 1.3
		},
		{
			"nombre": "Ella",
			"texto": "Or you're AFK.",
			"expresion": "confundida",
			"espera": 1.2
		}
	]

static func respuesta_cita_si() -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": "...",
			"expresion": "muy_sonrojada",
			"espera": 1.0
		},
		{
			"nombre": "Ella",
			"texto": "Well, look at you.",
			"expresion": "coqueta",
			"espera": 1.0
		},
		{
			"nombre": "Ella",
			"texto": "Trying to flirt with a drawing.",
			"expresion": "coqueta",
			"espera": 1.5
		},
		{
			"nombre": "Ella",
			"texto": "I don't know if that's sad...",
			"expresion": "neutral",
			"espera": 1.4
		},
		{
			"nombre": "Ella",
			"texto": "or bold.",
			"expresion": "sonrojada",
			"espera": 1.3
		},
		{
			"nombre": "Ella",
			"texto": "A little of both.",
			"expresion": "muy_sonrojada",
			"espera": 1.4
		},
		{
			"nombre": "Ella",
			"texto": "Don't make that face.",
			"expresion": "molesta",
			"espera": 1.1
		}
	]

static func respuesta_cita_no() -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": "...",
			"expresion": "neutral",
			"espera": 1.0
		},
		{
			"nombre": "Ella",
			"texto": "How cautious.",
			"expresion": "confundida",
			"espera": 1.1
		},
		{
			"nombre": "Ella",
			"texto": "Also pretty useless.",
			"expresion": "molesta",
			"espera": 1.2
		},
		{
			"nombre": "Ella",
			"texto": "Opportunities don't usually knock twice.",
			"expresion": "neutral",
			"espera": 1.6
		},
		{
			"nombre": "Ella",
			"texto": "You never know when something good might have happened.",
			"expresion": "coqueta",
			"espera": 1.6
		},
		{
			"nombre": "Ella",
			"texto": "Coward.",
			"expresion": "coqueta",
			"espera": 1.0
		}
	]

static func bloque_3_zen() -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": "I guess this works too.",
			"expresion": "neutral",
			"espera": 1.3
		},
		{
			"nombre": "Ella",
			"texto": "I talk.",
			"expresion": "confundida",
			"espera": 1.0
		},
		{
			"nombre": "Ella",
			"texto": "You stare into the void.",
			"expresion": "coqueta",
			"espera": 1.3
		},
		{
			"nombre": "Ella",
			"texto": "A pretty efficient conversation.",
			"expresion": "neutral",
			"espera": 1.4
		}
	]


static func bloque_3_indecisa() -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": "Well.",
			"expresion": "neutral",
			"espera": 1.0
		},
		{
			"nombre": "Ella",
			"texto": "We'll see how this ends.",
			"expresion": "confundida",
			"espera": 1.2
		}
	]


static func bloque_3_reto_completado(cantidad_clicks: int) -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": str(cantidad_clicks) + " clicks and counting.",
			"expresion": "confundida",
			"espera": 1.2
		},
		{
			"nombre": "Ella",
			"texto": "You completed the challenge.",
			"expresion": "coqueta",
			"espera": 1.0
		},
		{
			"nombre": "Ella",
			"texto": "Keep going if you want. I'm not going to tell you to stop.",
			"expresion": "molesta",
			"espera": 1.6
		}
	]


static func bloque_3_perdedor(cantidad_clicks: int) -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": str(cantidad_clicks) + " clicks.",
			"expresion": "neutral",
			"espera": 1.1
		},
		{
			"nombre": "Ella",
			"texto": "You didn't make it.",
			"expresion": "molesta",
			"espera": 1.0
		},
		{
			"nombre": "Ella",
			"texto": "There's not much else you can do about it now.",
			"expresion": "confundida",
			"espera": 1.3
		}
	]

# =========================================================
# DYNAMIC CHALLENGE TEXT
# =========================================================

static func anuncio_objetivo_inicial(objetivo: int) -> String:
	return "I want to see if you can reach " + str(objetivo) + " clicks."


static func anuncio_objetivo_siguiente(objetivo: int) -> String:
	return "This time, I want you to reach " + str(objetivo) + "."
