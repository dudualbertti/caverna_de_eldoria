extends CharacterBody2D

@export var show_tutorials:bool = false

var porta_colidindo = null

const MAX_SPEED = 200
var speed = MAX_SPEED

var velocity_change_speed = 20

var jump_velocity = -300
var gravity = 15

var vertical_velocity = 0

var is_walking = false
var on_air = false

var jumping = false
var can_jump = true
var can_die = true

var pressed_jump = false

@export var can_control = true
@export var max_jump_count = 1
@export var camera_bounds = Vector4(-999999, -999999, 999999, 999999)

var jump_count = max_jump_count

@onready var coyote_time_timer: Timer = $Coyote_Time_Timer
@onready var get_control_timer: Timer = $Get_Control_Timer
@onready var jump_buffer_timer: Timer = $Jump_Buffer_Timer

@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_passos: AudioStreamPlayer = $AudioPassos
@onready var audio_pulo: AudioStreamPlayer = $AudioPulo
@onready var camera: Camera2D = $Camera2D

@onready var rand = RandomNumberGenerator.new()


func Player():
	pass


func show_tutorial(num):
	match num:
		0:
			$AnimationPlayer.play("show_botoes_andar")
		1:
			$AnimationPlayer.play("show_botoes_pular")

func hide_tutorial(num):
	match num:
		0:
			$Botoes_andar.visible = false
		1:
			$Botoes_pular.visible = false


func die():
	if can_die:
		can_control = false
		velocity = Vector2.ZERO
		Global.goto_scene("res://Scenes/Menus/GameOver.tscn")


func _process(delta: float) -> void:
	Camera.shake_camera(camera, delta)
	if porta_colidindo:
		$Botoes_interagir.visible = true
		if Input.is_action_just_pressed("interact"):
			can_die = false
			porta_colidindo.interact()
	else:
		$Botoes_interagir.visible = false


func _ready() -> void:
	animation.play("idle")
	camera.limit_left = int(camera_bounds[0])
	camera.limit_top = int(camera_bounds[1])
	camera.limit_right = int(camera_bounds[2])
	camera.limit_bottom = int(camera_bounds[3])


func jump():
	if jump_count < 1:
		can_jump = false
	
	audio_pulo.pitch_scale = rand.randf_range(1.1, 1.5)
	audio_pulo.play()
	jump_count -= 1
	vertical_velocity = jump_velocity


func handle_jump_buffer(jump_press):
	
	if jump_press and not is_on_floor() and not jumping:
		jump_buffer_timer.start()
		
	if is_on_floor() and not jump_buffer_timer.is_stopped():
		jump()


func handle_coyote_time():
	if coyote_time_timer.is_stopped() and can_jump and max_jump_count < 2:
		coyote_time_timer.start()


func apply_gravity():
	
	if is_on_floor():
		return
	
	vertical_velocity += gravity
	vertical_velocity = clamp(vertical_velocity, jump_velocity, 250)
	velocity.y = vertical_velocity + gravity


func handle_vertical_movement():
	
	var jump_press = Input.is_action_pressed("jump")
	
	if is_on_floor():
		on_air = false
		can_jump = true
		jump_count = max_jump_count
		pressed_jump = false
		vertical_velocity = 0
		
	else:
		vertical_velocity += gravity
		on_air = true
		handle_coyote_time()
	
	if jump_press and can_jump and not pressed_jump:
		pressed_jump = true
		jump()
	
	handle_jump_buffer(jump_press)
	
	if Input.is_action_just_released("jump") and jumping:
		pressed_jump = false
		vertical_velocity = gravity
	
	jumping = velocity.y < 0 and not is_on_floor()
	
	vertical_velocity = clamp(vertical_velocity, jump_velocity, 250)
	
	velocity.y = vertical_velocity + gravity


func handle_horizontal_movement():
	var direction := Input.get_axis("left", "right")
	
	if direction > 0:
		animation.flip_h = false
	elif direction < 0:
		animation.flip_h = true
	
	if abs(direction):
		is_walking = true
	else:
		is_walking = false
	
	velocity.x = move_toward(velocity.x, direction*speed, velocity_change_speed)


func _physics_process(delta: float) -> void:
	
	if not can_control:
		apply_gravity()
		
		if not is_on_floor():
			animation.play("falling")
		else:
			animation.play("crouched")
			
			if get_control_timer.is_stopped():
				Sounds.play_sound(preload("res://Assets/Sounds/starting_cutscene_landing.ogg"))
				Camera.apply_shake(3)
				get_control_timer.start()
		
	else:
	
		if is_walking:
			animation.play("run")
		else:
			animation.play("idle")
		
		if not is_on_floor():
			if jumping:
				animation.play("jumping")
			else:
				animation.play("falling")
			
		
		handle_horizontal_movement()
		handle_vertical_movement()
	
	if is_walking and is_on_floor():
		if not audio_passos.playing:
			audio_passos.pitch_scale = rand.randf_range(0.9, 1.1)
			audio_passos.play()
	
	move_and_slide()


func _on_coyote_time_timer_timeout() -> void:
	can_jump = false


func _on_get_control_timer_timeout() -> void:
	can_control = true
