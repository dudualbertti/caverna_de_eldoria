extends Node2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("Player"):
		body.speed = body.MAX_SPEED/2
		body.poco_atual = self


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("Player"):
		if body.poco_atual == self:
			body.speed = body.MAX_SPEED
			body.poco_atual = null
