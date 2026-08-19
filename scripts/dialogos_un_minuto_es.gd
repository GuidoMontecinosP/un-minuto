class_name DialogosUnMinutoES
extends RefCounted

static func intro_inicial() -> Array: 
	return [
	{
		"nombre": "Ella",
		"texto": "¡Ah—!",
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
		"texto": "Genial.",
		"expresion": "molesta",
		"espera": 0.8
	},
	{
		"nombre": "Ella",
		"texto": "Choqué contigo.",
		"expresion": "neutral",
		"espera": 0.9
	},
	{
		"nombre": "Ella",
		"texto": "No pongas esa cara.",
		"expresion": "confundida",
		"espera": 0.9
	},
	{
		"nombre": "Ella",
		"texto": "También fue culpa mía.",
		"expresion": "neutral",
		"espera": 1.0
	},
	{
		"nombre": "Ella",
		"texto": "Iba tarde.",
		"expresion": "neutral",
		"espera": 0.8
	},
	{
		"nombre": "Ella",
		"texto": "Ahora voy tarde contigo.",
		"expresion": "coqueta",
		"espera": 1.1
	},
	{
		"nombre": "Ella",
		"texto": "Qué romántico.",
		"expresion": "coqueta",
		"espera": 1.0
	},
	{
		"nombre": "Ella",
		"texto": "Y apareció eso.",
		"expresion": "confundida",
		"mostrar_reloj": true,
		"espera": 0.9
	},
	{
		"nombre": "Ella",
		"texto": "Un minuto.",
		"expresion": "neutral",
		"espera": 0.9
	},
	{
		"nombre": "Ella",
		"texto": "Conmigo.",
		"expresion": "coqueta",
		"espera": 1.0
	},
	{
		"nombre": "Ella",
		"texto": "Podría ser peor.",
		"expresion": "neutral",
		"espera": 1.0
	}
]

static func intro_replay_1() -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": "¿Tú otra vez?",
			"expresion": "confundida",
			"espera": 0.9
		},
		{
			"nombre": "Ella",
			"texto": "Qué casualidad.",
			"expresion": "coqueta",
			"espera": 1.0
		},
		{
			"nombre": "Ella",
			"texto": "O no tanto.",
			"expresion": "molesta",
			"espera": 0.9
		},
		{
			"nombre": "Ella",
			"texto": "Bueno.",
			"expresion": "neutral",
			"espera": 0.8
		},
		{
			"nombre": "Ella",
			"texto": "Otra vez apareció eso.",
			"expresion": "confundida",
			"mostrar_reloj": true,
			"espera": 0.9
		},
		{
			"nombre": "Ella",
			"texto": "Un minuto.",
			"expresion": "neutral",
			"espera": 0.9
		},
		{
			"nombre": "Ella",
			"texto": "Otra vez conmigo.",
			"expresion": "coqueta",
			"espera": 1.0
		},
		{
			"nombre": "Ella",
			"texto": "Vamos a ver si esta vez sale distinto.",
			"expresion": "neutral",
			"espera": 1.3
		}
	]


static func intro_replay_2() -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": "Otra vez tú.",
			"expresion": "confundida",
			"espera": 0.9
		},
		{
			"nombre": "Ella",
			"texto": "Empiezo a pensar que esto no es casualidad.",
			"expresion": "coqueta",
			"espera": 1.4
		},
		{
			"nombre": "Ella",
			"texto": "Bueno, no me quejo.",
			"expresion": "sonrojada",
			"espera": 1.1
		},
		{
			"nombre": "Ella",
			"texto": "Ahí está el minuto de nuevo.",
			"expresion": "neutral",
			"mostrar_reloj": true,
			"espera": 0.9
		},
		{
			"nombre": "Ella",
			"texto": "A ver qué haces esta vez.",
			"expresion": "coqueta",
			"espera": 1.2
		}
	]


static func intro_replay_3() -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": "Tercera vez.",
			"expresion": "sorprendida",
			"espera": 0.9
		},
		{
			"nombre": "Ella",
			"texto": "¿Vienes seguido por aquí?",
			"expresion": "coqueta",
			"espera": 1.2
		},
		{
			"nombre": "Ella",
			"texto": "Es broma.",
			"expresion": "neutral",
			"espera": 0.8
		},
		{
			"nombre": "Ella",
			"texto": "Sé que sí.",
			"expresion": "molesta",
			"espera": 0.9
		},
		{
			"nombre": "Ella",
			"texto": "Ahí está tu minuto otra vez.",
			"expresion": "neutral",
			"mostrar_reloj": true,
			"espera": 0.9
		},
		{
			"nombre": "Ella",
			"texto": "Sorpréndeme.",
			"expresion": "coqueta",
			"espera": 1.0
		}
	]


# Para las repeticiones 4 a 9: texto genérico pero que
# menciona el número real de partidas.
static func intro_replay_generica(num: int) -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": "Van " + str(num) + " veces.",
			"expresion": "confundida",
			"espera": 1.0
		},
		{
			"nombre": "Ella",
			"texto": "A este ritmo vamos a terminar viviendo juntos.",
			"expresion": "coqueta",
			"espera": 1.4
		},
		{
			"nombre": "Ella",
			"texto": "Bueno.",
			"expresion": "neutral",
			"espera": 0.7
		},
		{
			"nombre": "Ella",
			"texto": "Ahí está tu minuto.",
			"expresion": "neutral",
			"mostrar_reloj": true,
			"espera": 0.9
		},
		{
			"nombre": "Ella",
			"texto": "Otra vez.",
			"expresion": "coqueta",
			"espera": 0.9
		}
	]


# Desde la partida número 10 en adelante: intro corta,
# vamos directo al grano.
static func intro_replay_corta() -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": "Tú de nuevo.",
			"expresion": "neutral",
			"espera": 0.8
		},
		{
			"nombre": "Ella",
			"texto": "Ya sabes cómo va esto.",
			"expresion": "coqueta",
			"mostrar_reloj": true,
			"espera": 0.9
		}
	]



# =========================================================
# BLOQUE 1 — TUTORIAL
# =========================================================

static func bloque_1() -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": "Bueno.",
			"expresion": "neutral",
			"espera": 0.9
		},
		{
			"nombre": "Ella",
			"texto": "Parece que tú no puedes hablar.",
			"expresion": "confundida",
			"espera": 1.3
		},
		{
			"nombre": "Ella",
			"texto": "Conveniente para mí.",
			"expresion": "coqueta",
			"espera": 1.1
		},
		{
			"nombre": "Ella",
			"texto": "Probemos algo.",
			"expresion": "neutral",
			"espera": 1.0
		},
		{
			"nombre": "Ella",
			"texto": "Haz clic si me estás escuchando.",
			"expresion": "coqueta",
			"pregunta": "tutorial",
			"ventana": 5.0
		}
	]


# =========================================================
# BLOQUE 2 — RETO ACEPTADO
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
			"texto": "Cumpliste el reto.",
			"expresion": "coqueta",
			"espera": 1.1
		},
		{
			"nombre": "Ella",
			"texto": "Vamos a subir la apuesta.",
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
			"texto": "Y esta vez no te me relajes.",
			"expresion": "molesta",
			"espera": 1.1
		}
	]


# =========================================================
# BLOQUE 2 — SILENCIO TOTAL (ni siquiera respondió el tutorial)
# Ruta zen: corre sola, sin más preguntas ni clics.
# =========================================================

static func bloque_2_zen() -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": "Ni un clic.",
			"expresion": "confundida",
			"espera": 1.1
		},
		{
			"nombre": "Ella",
			"texto": "Ni siquiera el primero.",
			"expresion": "neutral",
			"espera": 1.2
		},
		{
			"nombre": "Ella",
			"texto": "Está bien.",
			"expresion": "coqueta",
			"espera": 1.0
		},
		{
			"nombre": "Ella",
			"texto": "De hecho, creo que ya ni podrías hacer clic aunque quisieras.",
			"expresion": "confundida",
			"espera": 1.6
		},
		{
			"nombre": "Ella",
			"texto": "Entraste en un estado zen tan profundo que se te olvidó cómo funcionan los dedos.",
			"expresion": "coqueta",
			"espera": 1.9
		},
		{
			"nombre": "Ella",
			"texto": "Voy a hablar sola entonces.",
			"expresion": "confundida",
			"espera": 1.3
		},
		{
			"nombre": "Ella",
			"texto": "Se me da bien.",
			"expresion": "coqueta",
			"espera": 1.1
		}
	]


# =========================================================
# BLOQUE 2 — INTENTO FALLIDO (respondió el tutorial pero
# nunca volvió a clickear: no llegó a aceptar el reto)
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
			"texto": "Ni lo intentaste.",
			"expresion": "confundida",
			"espera": 1.2
		},
		{
			"nombre": "Ella",
			"texto": "Qué sospechosamente sensato.",
			"expresion": "coqueta",
			"espera": 1.3
		},
		{
			"nombre": "Ella",
			"texto": "A ver.",
			"expresion": "neutral",
			"espera": 0.8
		},
		{
			"nombre": "Ella",
			"texto": "Haz clic si sigues ahí.",
			"expresion": "coqueta",
			"pregunta": "sigues_ahi",
			"ventana": 5.0
		}
	]


# =========================================================
# BLOQUE 2 — PERDEDOR (aceptó el reto, siguió clickeando,
# pero no le alcanzó para llegar al objetivo)
# =========================================================

static func bloque_2_perdedor() -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": "Vaya.",
			"expresion": "sorprendida",
			"espera": 0.9
		},
		{
			"nombre": "Ella",
			"texto": "Sí que lo intentaste.",
			"expresion": "confundida",
			"espera": 1.1
		},
		{
			"nombre": "Ella",
			"texto": "Pero no te alcanzó.",
			"expresion": "molesta",
			"espera": 1.1
		},
		{
			"nombre": "Ella",
			"texto": "Qué vergüenza, la verdad.",
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
			"texto": "¿En serio?",
			"expresion": "molesta",
			"espera": 1.0
		},
		{
			"nombre": "Ella",
			"texto": "Ni siquiera ha empezado el minuto.",
			"expresion": "confundida",
			"espera": 1.3
		},
		{
			"nombre": "Ella",
			"texto": "Y ya estás desesperado por hacer clic.",
			"expresion": "molesta",
			"espera": 1.4
		},
		{
			"nombre": "Ella",
			"texto": "No, gracias.",
			"expresion": "molesta",
			"espera": 1.0
		},
		{
			"nombre": "Ella",
			"texto": "Ponlo en tu currículum: impaciencia crónica.",
			"expresion": "confundida",
			"espera": 1.6
		},
		{
			"nombre": "Ella",
			"texto": "Búscate a otra.",
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
			"texto": "Sí me estabas escuchando.",
			"expresion": "coqueta",
			"espera": 1.2
		},
		{
			"nombre": "Ella",
			"texto": "Qué atento.",
			"expresion": "coqueta",
			"espera": 1.0
		},
		{
			"nombre": "Ella",
			"texto": "Entonces ya tenemos un idioma.",
			"expresion": "neutral",
			"espera": 1.3
		},
		{
			"nombre": "Ella",
			"texto": "Uno bastante limitado.",
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
			"texto": "Sin trampas.",
			"expresion": "molesta",
			"espera": 1.0
		},
		{
			"nombre": "Ella",
			"texto": "Te reto.",
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
			"texto": "Bueno.",
			"expresion": "neutral",
			"espera": 0.9
		},
		{
			"nombre": "Ella",
			"texto": "Esto va a ser una conversación difícil.",
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
			"texto": "Sí estabas escuchando.",
			"expresion": "coqueta",
			"espera": 1.2
		},
		{
			"nombre": "Ella",
			"texto": "Todo un caballero.",
			"expresion": "coqueta",
			"espera": 1.1
		},
		{
			"nombre": "Ella",
			"texto": "Tengo una pregunta.",
			"expresion": "sonrojada",
			"espera": 1.1
		},
		{
			"nombre": "Ella",
			"texto": "Haz clic si aceptarías una cita conmigo.",
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
			"texto": "Vaya.",
			"expresion": "neutral",
			"espera": 0.9
		},
		{
			"nombre": "Ella",
			"texto": "De verdad eres imperturbable.",
			"expresion": "coqueta",
			"espera": 1.3
		},
		{
			"nombre": "Ella",
			"texto": "O estás AFK.",
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
			"texto": "Mira tú.",
			"expresion": "coqueta",
			"espera": 1.0
		},
		{
			"nombre": "Ella",
			"texto": "Intentando ligar con un dibujo.",
			"expresion": "coqueta",
			"espera": 1.5
		},
		{
			"nombre": "Ella",
			"texto": "No sé si es triste...",
			"expresion": "neutral",
			"espera": 1.4
		},
		{
			"nombre": "Ella",
			"texto": "o atrevido.",
			"expresion": "sonrojada",
			"espera": 1.3
		},
		{
			"nombre": "Ella",
			"texto": "Un poco de ambos.",
			"expresion": "muy_sonrojada",
			"espera": 1.4
		},
		{
			"nombre": "Ella",
			"texto": "No pongas esa cara.",
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
			"texto": "Qué prudente.",
			"expresion": "confundida",
			"espera": 1.1
		},
		{
			"nombre": "Ella",
			"texto": "También qué inútil.",
			"expresion": "molesta",
			"espera": 1.2
		},
		{
			"nombre": "Ella",
			"texto": "Las oportunidades no suelen avisar dos veces.",
			"expresion": "neutral",
			"espera": 1.6
		},
		{
			"nombre": "Ella",
			"texto": "Nunca sabes cuándo algo bueno iba a pasar.",
			"expresion": "coqueta",
			"espera": 1.6
		},
		{
			"nombre": "Ella",
			"texto": "Cobarde.",
			"expresion": "coqueta",
			"espera": 1.0
		}
	]

static func bloque_3_zen() -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": "Supongo que esto también funciona.",
			"expresion": "neutral",
			"espera": 1.3
		},
		{
			"nombre": "Ella",
			"texto": "Yo hablo.",
			"expresion": "confundida",
			"espera": 1.0
		},
		{
			"nombre": "Ella",
			"texto": "Tú contemplas el vacío.",
			"expresion": "coqueta",
			"espera": 1.3
		},
		{
			"nombre": "Ella",
			"texto": "Una conversación bastante eficiente.",
			"expresion": "neutral",
			"espera": 1.4
		}
	]


static func bloque_3_indecisa() -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": "Bueno.",
			"expresion": "neutral",
			"espera": 1.0
		},
		{
			"nombre": "Ella",
			"texto": "Ya veremos cómo termina esto.",
			"expresion": "confundida",
			"espera": 1.2
		}
	]


static func bloque_3_reto_completado(cantidad_clicks: int) -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": str(cantidad_clicks) + " clics y contando.",
			"expresion": "confundida",
			"espera": 1.2
		},
		{
			"nombre": "Ella",
			"texto": "Cumpliste el reto.",
			"expresion": "coqueta",
			"espera": 1.0
		},
		{
			"nombre": "Ella",
			"texto": "Sigue si quieres. No te voy a decir que pares.",
			"expresion": "molesta",
			"espera": 1.6
		}
	]


static func bloque_3_perdedor(cantidad_clicks: int) -> Array:
	return [
		{
			"nombre": "Ella",
			"texto": str(cantidad_clicks) + " clics.",
			"expresion": "neutral",
			"espera": 1.1
		},
		{
			"nombre": "Ella",
			"texto": "No llegaste.",
			"expresion": "molesta",
			"espera": 1.0
		},
		{
			"nombre": "Ella",
			"texto": "Ya no hay mucho más que hacer al respecto.",
			"expresion": "confundida",
			"espera": 1.3
		}
	]

# =========================================================
# TEXTOS DINÁMICOS DEL RETO
# =========================================================

static func anuncio_objetivo_inicial(objetivo: int) -> String:
	return "Quiero ver si llegas a " + str(objetivo) + " clics."


static func anuncio_objetivo_siguiente(objetivo: int) -> String:
	return "Esta vez quiero llegar a " + str(objetivo) + "."
