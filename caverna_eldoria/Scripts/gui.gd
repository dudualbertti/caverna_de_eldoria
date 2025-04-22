extends Control

@onready var label_tempo: Label = $CanvasLayer/VBoxContainer/LabelTempo
@onready var label_pontos: Label = $CanvasLayer/VBoxContainer/LabelPontos


func _process(delta):
	var time = Global.current_time
	
	var seconds = "%s%d"%["" if time % 60 >= 10 else "0", time % 60]
	
	label_tempo.text = "%d:%s" % [time/60, seconds]
	label_pontos.text = "Pontos: %d" % Global.pontos


func _on_countdown_timer_timeout() -> void:
	if Global.current_time > 0:
		Global.current_time -= 1
	else:
		get_parent().get_parent().die()
