extends CharacterBody2D

var random_shake_strength: float = 30.0
var shake_decay_rate: float = 5.0
var shake_strength: float = 0.0

var is_on_porta = false

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

var pressed_jump = false

@onready var rand = RandomNumberGenerator.new()
@export var can_control = true
@export var max_jump_count = 1
@export var camera_bounds = Vector4(-999999, -999999, 999999, 999999)

var jump_count = max_jump_count

@onready var jump_buffer_timer: Timer = $Jump_Buffer_Timer
@onready var coyote_time_timer: Timer = $Coyote_Time_Timer
@onready var get_control_timer: Timer = $Get_Control_Timer
@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var camera: Camera2D = $Camera2D


func Player():
	pass

func _process(delta: float) -> void:
	shake_strength = lerp(shake_strength, 0.0, shake_decay_rate * delta)
	camera.offset = get_random_offset()
	
	if is_on_porta:
		if Input.is_action_just_pressed("interact"):
			get_tree().change_scene_to_file("res://Scenes/main.tscn")


func get_random_offset():
	return Vector2(
		rand.randf_range(-shake_strength, shake_strength),
		rand.randf_range(-shake_strength, shake_strength)
	)

	
func _ready() -> void:
	animation.play("idle")
	camera.limit_left = int(camera_bounds[0])
	camera.limit_top = int(camera_bounds[1])
	camera.limit_right = int(camera_bounds[2])
	camera.limit_bottom = int(camera_bounds[3])
	
	print(camera_bounds)

func jump():
	if jump_count < 1:
		can_jump = false
	
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
				shake_screen(3)
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

	move_and_slide()
	

func shake_screen(strength):
	shake_strength = strength

func _on_coyote_time_timer_timeout() -> void:
	can_jump = false


func _on_get_control_timer_timeout() -> void:
	can_control = true
