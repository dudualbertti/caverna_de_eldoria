extends Control

@onready var text_edit: TextEdit = $TextEdit


func _ready():
	for score in Global.score_board:
		text_edit.text += "%s: %d pontos\n" % [score, Global.score_board[score]]


func _on_button_pressed() -> void:
	Global.goto_scene("res://Scenes/Menus/menu.tscn")
