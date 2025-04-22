extends Control

@onready var text_edit: TextEdit = $VBoxContainer/TextEdit
@onready var button_avancar: Button = $VBoxContainer/ButtonAvancar


func _on_button_avancar_pressed() -> void:
	Global.current_name = text_edit.text.to_upper()
	print(Global.current_name)
	Global.current_time = 60*5
	Global.goto_scene("res://Scenes/Levels/level1.tscn")


func _on_text_edit_text_changed() -> void:
	if len(text_edit.text) > 0:
		button_avancar.disabled = false
	else:
		button_avancar.disabled = true


func _on_button_voltar_pressed() -> void:
	Global.goto_scene("res://Scenes/Menus/menu.tscn")
