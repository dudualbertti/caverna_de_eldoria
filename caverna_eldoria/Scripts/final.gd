extends Control

@onready var label_cristal_p: Label = $VBoxContainer3/HBoxContainer/LabelCristalP
@onready var label_cristal_m: Label = $VBoxContainer3/HBoxContainer2/LabelCristalM
@onready var label_cristal_r: Label = $VBoxContainer3/HBoxContainer3/LabelCristalR

@onready var label_tempo: Label = $VBoxContainer4/LabelTempo
@onready var label_final: Label = $VBoxContainer4/LabelFinal

func _ready():
	Global.game_end = true
	var time = Global.current_time
	
	Global.pontos += time*5
	
	Global.save_game()
	
	var cristais_p = Global.cristais_coletados[0]
	var cristais_m = Global.cristais_coletados[1]
	var cristais_r = Global.cristais_coletados[2]
	
	
	label_cristal_p.text = "x %d (%d pts)" % [cristais_p, cristais_p*10]
	label_cristal_m.text = "x %d (%d pts)" % [cristais_m, cristais_m*25]
	label_cristal_r.text = "x %d (%d pts)" % [cristais_r, cristais_r*50]
	
	label_tempo.text += "%d (x5 = %d pts)" % [time, time*5]
	
	label_final.text += "%d pontos" % Global.pontos


func _on_button_reiniciar_pressed() -> void:
	Global.goto_scene("res://Scenes/Levels/level1.tscn")


func _on_button_sair_pressed() -> void:
	Global.goto_scene("res://Scenes/Menus/menu.tscn")
