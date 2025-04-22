extends Node

var music_player := AudioStreamPlayer.new()


func _ready():
	add_child(music_player)
	var my_music_stream = preload("res://Assets/Sounds/soundtrack.ogg")
	Audio.play_music(my_music_stream)


func play_music(music_stream):
	music_player.stream = music_stream
	music_player.play()


func stop_music():
	music_player.stop()
