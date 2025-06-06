extends Node2D

@export var offset = Vector2(0, -10)
@export var duration = 5.0

@onready var animatable_body_2d: AnimatableBody2D = $AnimatableBody2D

var tween

func _ready():
	start_tween()

func start_tween():
	tween = get_tree().create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	tween.set_loops().set_parallel(false)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(animatable_body_2d, "position", offset, duration / 2)
	tween.tween_property(animatable_body_2d, "position", Vector2.ZERO, duration / 2)
