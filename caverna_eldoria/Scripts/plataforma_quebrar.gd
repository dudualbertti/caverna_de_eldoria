extends Node2D

var stepped = false
@onready var quebrar_timer: Timer = $QuebrarTimer
@onready var sprite: AnimatedSprite2D = $Sprite


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("Player"):
		if not stepped:
			stepped = true
		else:
			sprite.play("quebrada")
			quebrar_timer.start()


func _on_quebrar_timer_timeout() -> void:
	queue_free()
