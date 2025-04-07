extends Node2D

var ativado = false
var extendido = false

@onready var ativar_timer: Timer = $AtivarTimer
@onready var desativar_timer: Timer = $DesativarTimer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	animated_sprite_2d.play("idle")


func _on_ativar_timer_timeout() -> void:
	if not extendido:
		extendido = true
		animated_sprite_2d.play("extendido")
		desativar_timer.start()

	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("Player"):
		if not ativado:
			ativado = true
			animated_sprite_2d.play("ativado")
			ativar_timer.start()


func _on_desativar_timer_timeout() -> void:
	extendido = false
	ativado = false
	animated_sprite_2d.play("idle")
