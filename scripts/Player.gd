extends CharacterBody2D

signal deadsignal

@export var speed = 250.0
@export var jump_speed = -550.0
@export var gravity = 2000.0
@export var friction = 0.5
@export var acceleration = 0.25
@export var max_fall_speed = 500

const JUMP_BUFFER_TIME = 10

var jump_buffer_counter = 0

@onready var anim = $turn/AnimatedSprite2D
@onready var coyote_timer = $coyotetimer

var can_move = true

func _physics_process(delta):
	if can_move:
		apply_gravity(delta)
		process_movement_input(delta)
		update_animation()
		var was_on_floor = is_on_floor()
		move_and_slide()
		var just_left_ledge = was_on_floor and not is_on_floor() and velocity.y >= 0
		process_jump_input(just_left_ledge,was_on_floor)

func apply_gravity(delta):
	velocity.y += gravity * delta
	velocity.y = clamp(velocity.y, jump_speed, max_fall_speed)

func process_movement_input(delta):
	var direction = Input.get_axis("Left", "Right")
	if direction != 0:
		velocity.x = lerp(velocity.x, direction * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction)
	velocity.x = clamp(velocity.x, -speed, speed)
	
	if velocity.x != 0 and is_on_floor() and $Timer.time_left <= 0:
		$steps.pitch_scale = randf_range(0.8, 1.2)
		$steps.play()
		$Timer.start(0.2)

func process_jump_input(just_left_ledge,was_on_floor):
	if Input.is_action_just_pressed("Jump"):
		jump_buffer_counter = JUMP_BUFFER_TIME
	if jump_buffer_counter > 0:
		jump_buffer_counter -= 1
	if (is_on_floor() or coyote_timer.time_left > 0) and Input.is_action_just_pressed("Jump"):
		$jump.play()
		velocity.y = jump_speed
	elif jump_buffer_counter > 0 and is_on_floor():
		$jump.play()
		velocity.y = jump_speed
		jump_buffer_counter = 0
	if Input.is_action_just_released("Jump"):
		velocity.y += 200
	if just_left_ledge:
		coyote_timer.start(0.1)
	#hata olabilir source koda bak
	if not was_on_floor and is_on_floor():
		$land.play()

func update_animation():
	if velocity.x == 0:
		anim.animation = "idle"
	else:
		$turn.scale.x = sign(velocity.x)
		anim.animation = "walking"

