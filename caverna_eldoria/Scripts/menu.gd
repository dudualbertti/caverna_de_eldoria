extends Control

var my_music_stream


func _ready() -> void:
	my_music_stream = preload("res://Assets/Sounds/soundtrack.ogg")
	Audio.play_music(my_music_stream)


func _on_button_comecar_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/level1.tscn")


func _on_button_sair_pressed() -> void:
	get_tree().quit()
