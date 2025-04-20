extends Node

var random_shake_strength: float = 30.0
var shake_decay_rate: float = 5.0
var shake_strength: float = 0.0


func shake_camera(camera:Camera2D, delta):
	if shake_strength > 0.0:
		shake_strength = lerp(shake_strength, 0.0, shake_decay_rate * delta)
		camera.offset = get_random_offset()


func get_random_offset():
	return Vector2(
		Global.rand.randf_range(-shake_strength, shake_strength),
		Global.rand.randf_range(-shake_strength, shake_strength)
	)


func apply_shake(strength):
	shake_strength = strength
