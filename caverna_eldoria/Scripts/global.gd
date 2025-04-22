extends Node

var current_scene = "res://Scenes/Menus/menu.tscn"
var last_scene = current_scene

var current_name = ""

var score_board = {}

var current_time = 0
var pontos = 0

var rand = RandomNumberGenerator.new()

func _ready():
	load_game()


func load_game():
	if not FileAccess.file_exists("user://savegame.save"):
		return
		
	var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	var json = JSON.new()
	score_board = json.parse_string(save_file.get_as_text())
	

func goto_scene(scene_path):
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finised
	last_scene = current_scene
	current_scene = scene_path
	get_tree().change_scene_to_file(scene_path)


func save_game():
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	if current_name not in score_board:
		score_board[current_name] = pontos
	else:
		if pontos > score_board[current_name]:
			score_board[current_name] = pontos
	save_file.store_string(JSON.stringify(score_board))
