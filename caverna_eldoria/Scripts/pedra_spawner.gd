extends Node2D

@onready var drop_pedra_timer: Timer = $DropPedraTimer

var pedra_scene = preload("res://Scenes/pedra.tscn")
var can_spawn = true

var distance_to_player = 0.0

func _process(delta: float) -> void:
	var player = get_parent().get_node("Player")
	
	if player:
		distance_to_player = abs(player.position.x - position.x)
	
	if  distance_to_player < 20:
		if can_spawn:
			can_spawn = false
			drop_pedra_timer.start()


func _on_drop_pedra_timer_timeout() -> void:
	var pedra = pedra_scene.instantiate()
	call_deferred("add_child",pedra)
