extends CharacterBody2D


var speed = 300.0
var velocity_change_speed = 20

var jump_velocity = -400
var gravity = 10

var vertical_velocity = 0

var jumping = false
var can_jump = true

@onready var jump_buffer_timer: Timer = $Jump_Buffer_Timer
@onready var coyote_time_timer: Timer = $Coyote_Time_Timer


func jump():
	can_jump = false
	vertical_velocity = jump_velocity


func handle_jump_buffer(jump_press):
	
	if jump_press and not is_on_floor() and not jumping:
		jump_buffer_timer.start()
		
	if is_on_floor() and not jump_buffer_timer.is_stopped():
		jump()
		

func handle_coyote_time():
	if coyote_time_timer.is_stopped() and can_jump:
		coyote_time_timer.start()
	
	print(jump_buffer_timer.is_stopped())
	
func handle_vertical_movement():
	
	var jump_press = Input.is_action_pressed("jump")
	
	if is_on_floor():
		can_jump = true
		vertical_velocity = 0
	else:
		vertical_velocity += gravity
		handle_coyote_time()
	
	if jump_press and can_jump:
		jump()
	
	handle_jump_buffer(jump_press)
	
	if Input.is_action_just_released("jump") and jumping:
		vertical_velocity = gravity

	
	jumping = velocity.y < 0 and not is_on_floor()
	
	velocity.y = vertical_velocity + gravity

func handle_horizontal_movement():
	var direction := Input.get_axis("left", "right")

	velocity.x = move_toward(velocity.x, direction*speed, velocity_change_speed)


func _physics_process(delta: float) -> void:
	
	handle_horizontal_movement()
	handle_vertical_movement()

	move_and_slide()


func _on_coyote_time_timer_timeout() -> void:
	can_jump = false
