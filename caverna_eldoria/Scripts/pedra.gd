extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D
var angular_speed = PI
@onready var can_die: Timer = $CanDie

var grav: float = 0
var vspd = 0


func _physics_process(delta: float) -> void:
	
	rotation += angular_speed * delta
	
	grav = lerp(grav, 0.2, 0.01)
	
	vspd += grav
	
	position.y += vspd + grav


func _on_timer_timeout() -> void:
	queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if can_die.is_stopped():
		queue_free()
