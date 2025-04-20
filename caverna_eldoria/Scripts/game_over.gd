extends Control


func _on_button_reiniciar_pressed() -> void:
	Global.goto_scene(Global.last_scene)


func _on_button_sair_pressed() -> void:
	Global.goto_scene("res://Scenes/Menus/menu.tscn")
