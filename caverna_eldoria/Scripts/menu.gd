extends Control


func _ready() -> void:
	Global.pontos = 0


func _on_button_comecar_pressed() -> void:
	Global.goto_scene("res://Scenes/Menus/escolher_nome.tscn")


func _on_button_sair_pressed() -> void:
	get_tree().quit()


func _on_button_scoreboard_pressed() -> void:
	Global.goto_scene("res://Scenes/Menus/score_board.tscn")
