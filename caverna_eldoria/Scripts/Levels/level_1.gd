extends Node2D

func _ready():
	Global.pontos = 0
	Global.current_time = int(60*3.5)
	Global.game_end = false
	Global.cristais_coletados = {
		0: 0,
		1: 0,
		2: 0
	}
