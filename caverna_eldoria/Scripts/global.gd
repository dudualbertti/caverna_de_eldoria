extends Node

var current_scene = "res://Scenes/Menus/menu.tscn"
var last_scene = current_scene

var current_time = 20
var pontos = 0

var rand = RandomNumberGenerator.new()


func goto_scene(scene_path):
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finised
	last_scene = current_scene
	current_scene = scene_path
	get_tree().change_scene_to_file(scene_path)
