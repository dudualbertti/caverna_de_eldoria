extends CharacterBody2D

const MAX_SPEED = 200
var speed = MAX_SPEED

var velocity_change_speed = 50

var jump_velocity = -300
var gravity = 15

var vertical_velocity = 0

var is_walking = false

var jumping = false
var can_jump = true

var pressed_jump = false

@export var max_jump_count = 1
var jump_count = max_jump_count

@onready var jump_buffer_timer: Timer = $Jump_Buffer_Timer
@onready var coyote_time_timer: Timer = $Coyote_Time_Timer
@onready var animation: AnimatedSprite2D = $AnimatedSprite2D


func Player():
	pass

func _ready() -> void:
	animation.play("idle")

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
	
	
func handle_vertical_movement():
	
	var jump_press = Input.is_action_pressed("jump")
	
	if is_on_floor():
		can_jump = true
		jump_count = max_jump_count
		pressed_jump = false
		vertical_velocity = 0
	else:
		vertical_velocity += gravity
		handle_coyote_time()
	
	if jump_press and can_jump and not pressed_jump:
		pressed_jump = true
		jump()
	
	handle_jump_buffer(jump_press)
	
	if Input.is_action_just_released("jump") and jumping:
		pressed_jump = false
		vertical_velocity = gravity
	
	jumping = velocity.y < 0 and not is_on_floor()
	
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


func _on_coyote_time_timer_timeout() -> void:
	can_jump = false
