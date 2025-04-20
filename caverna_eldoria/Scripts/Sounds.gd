extends Node

var sound_player := AudioStreamPlayer.new()


func _ready():
	add_child(sound_player)


func play_sound(sound_stream, pitch_scale=1.0, volume:float=0.0):
	sound_player.stream = sound_stream
	sound_player.pitch_scale = pitch_scale
	sound_player.volume_db = volume
	sound_player.play()


func stop_music():
	sound_player.stop()
