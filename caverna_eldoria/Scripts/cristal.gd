extends Node2D

@export var offset = Vector2(0, -10)
@export var duration = 5.0

@onready var sprite_2d: Sprite2D = $Sprite2D

var tween : Tween

func _ready():
	start_tween()

func start_tween():
	tween = get_tree().create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	tween.set_loops().set_parallel(false)
	tween.tween_property(sprite_2d, "position", offset, duration / 2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property(sprite_2d, "position", Vector2.ZERO, duration / 2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("Player"):
		tween.kill()
		queue_free()
