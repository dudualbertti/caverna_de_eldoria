extends Control

@onready var text_edit: TextEdit = $TextEdit


func _ready():
	var ranking_ordenado = Global.score_board.keys()
	ranking_ordenado.sort_custom(func(a,b):
		return Global.score_board[b] < Global.score_board[a]
	)

	for score in ranking_ordenado:
		text_edit.text += "%s: %d pontos\n" % [score, Global.score_board[score]]

func _on_button_pressed() -> void:
	Global.goto_scene("res://Scenes/Menus/menu.tscn")
