extends CharacterBody2D

signal deadsignal

@export var speed = 250.0
@export var jump_speed = -550.0
@export var gravity = 2000.0
@export var friction = 0.5
@export var acceleration = 0.25
@export var max_fall_speed = 500
@export var health = 100

const JUMP_BUFFER_TIME = 10

var isbeinghit
var jump_buffer_counter = 0

@onready var anim = $turn/WalkComp
@onready var coyote_timer = $coyotetimer
@export var fadeanim:AnimationPlayer

var alive = true

var can_move = true
func _ready():
	State.player = self
	
func _physics_process(delta):
	update_animation()
	if can_move:
		apply_gravity(delta)
		process_movement_input(delta)
		var was_on_floor = is_on_floor()
		move_and_slide()
		var just_left_ledge = was_on_floor and not is_on_floor() and velocity.y >= 0
		process_jump_input(just_left_ledge,was_on_floor)
	$UI/HPBar.value = health
	if !alive:
		velocity.x = 0

func apply_gravity(delta):
	velocity.y += gravity * delta
	velocity.y = clamp(velocity.y, jump_speed, max_fall_speed)

func process_movement_input(delta):
	var direction = Input.get_axis("Left", "Right")
	if($InvFrames.is_playing() == false):
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
	if State.VisionCompHave:
		$turn/VisionComp.visible = true
		


func _on_ui_dead():
	if alive:
		var _particle = preload("res://scenes/explosion.tscn").instantiate()
		_particle.position = global_position
		_particle.emitting = true
		get_tree().current_scene.add_child(_particle)
		emit_signal("deadsignal")
		can_move = false
		alive = false

