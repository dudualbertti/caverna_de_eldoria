extends Node2D

@onready var quebrar_timer: Timer = $QuebrarTimer
@onready var sprite: AnimatedSprite2D = $Sprite
@onready var rand = RandomNumberGenerator.new()

var destroying = false
var shake_decay_rate = 5.0
var shake_strength = 0.0

func _process(delta: float) -> void:
	if destroying:
		
		shake_strength = lerp(shake_strength, 0.0, shake_decay_rate*delta)
		
		sprite.offset = Vector2(
			rand.randf_range(-shake_strength, shake_strength),
			rand.randf_range(-shake_strength, shake_strength)
		)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("Player"):
		shake_strength = 1.0
		sprite.play("quebrada")
		destroying = true
		quebrar_timer.start()


func _on_quebrar_timer_timeout() -> void:
	Sounds.play_sound(preload("res://Assets/Sounds/rock_break.ogg"), rand.randf_range(0.9, 1.1))
	queue_free()
