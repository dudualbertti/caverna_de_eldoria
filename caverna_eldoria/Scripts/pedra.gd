extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D
var angular_speed = PI

var grav = 0.4
var vspd = 0

func _physics_process(delta: float) -> void:
	rotation += angular_speed * delta
	
	vspd += grav
	
	position.y += vspd + grav


func _on_timer_timeout() -> void:
	queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	queue_free()
