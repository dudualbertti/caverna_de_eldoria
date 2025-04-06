extends Node2D

var stepped = false
@onready var quebrar_timer: Timer = $QuebrarTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("Player"):
		if not stepped:
			stepped = true
		else:
			quebrar_timer.start()


func _on_area_2d_body_exited(body: Node2D) -> void:
	pass # Replace with function body.


func _on_quebrar_timer_timeout() -> void:
	queue_free()
