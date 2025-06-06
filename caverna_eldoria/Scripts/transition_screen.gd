extends CanvasLayer

signal on_transition_finised

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var color_rect: ColorRect = $ColorRect


func _ready():
	color_rect.visible = false
	animation_player.animation_finished.connect(_on_animation_finished)


func _on_animation_finished(anim_name):
	if anim_name == "fade_to_black":
		on_transition_finised.emit()
		animation_player.play("fade_to_normal")
		
	elif anim_name == "fade_to_normal":
		color_rect.visible = false


func transition():
	color_rect.visible = true
	for cristal in get_tree().get_nodes_in_group("cristais"):
		cristal.tween.kill()
		
	for plataforma in get_tree().get_nodes_in_group("plataformas"):
		plataforma.tween.kill()
		
	animation_player.play("fade_to_black")
