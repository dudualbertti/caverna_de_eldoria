extends Node2D

@export var next_scene: PackedScene
var can_interact = true


func _on_area_2d_body_entered(body: Node2D) -> void:
	
	if body.has_method("Player"):
		body.porta_colidindo = self


func interact():
	if can_interact:
		can_interact = false
		#Global.pontos += 5*Global.current_time
		Global.save_game()
		Global.goto_scene(next_scene.resource_path)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("Player"):
		body.porta_colidindo = null
