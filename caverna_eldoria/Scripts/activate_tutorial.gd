extends Node2D

@export var num = 0
@onready var area: Area2D = $Area2D
@export var player: CharacterBody2D

var flag = true

func _process(delta: float) -> void:
	if area.overlaps_body(player) and flag:
		flag = false
		player.show_tutorial(num)
	
	match num:
		0:
			if player.can_control:
				if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
					player.hide_tutorial(num)
					queue_free()
		1:
			if Input.is_action_pressed("jump") and not player.on_air and not player.jumping:
				player.hide_tutorial(num)
				queue_free()
