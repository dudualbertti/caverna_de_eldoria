extends Node2D

var ativado = false
var extendido = false

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var area: Area2D = $area
@onready var ativar_timer: Timer = $AtivarTimer
@onready var audio_ativado: AudioStreamPlayer = $AudioAtivado
@onready var audio_extendido: AudioStreamPlayer = $AudioExtendido
@onready var collision_shape_2d: CollisionShape2D = $area/CollisionShape2D
@onready var desativar_timer: Timer = $DesativarTimer

var player = null

func _ready() -> void:
	animated_sprite_2d.play("idle")


func _process(delta):
	if extendido:
		if area.overlaps_body(player):
			player.die()
			collision_shape_2d.disabled = true


func _on_ativar_timer_timeout() -> void:
	if not extendido:
		extendido = true
		animated_sprite_2d.play("extendido")
		desativar_timer.start()
		audio_extendido.play()

	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("Player"):
		player = body
		if not ativado:
			ativado = true
			audio_ativado.pitch_scale = Global.rand.randf_range(0.9, 1.1)
			audio_ativado.play()
			animated_sprite_2d.play("ativado")
			ativar_timer.start()


func _on_desativar_timer_timeout() -> void:
	extendido = false
	ativado = false
	player = null
	animated_sprite_2d.play("idle")
