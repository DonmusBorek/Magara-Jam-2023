extends CharacterBody2D

signal deadsignal

@export var speed = 250.0
@export var jump_speed = -550.0
@export var gravity = 2000.0
@export var friction = 0.5
@export var acceleration = 0.25
@export var max_fall_speed = 500
@export var health = 100

var candash = false
var dashing = false
var noluyozipliyoz = false

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
	State.playerDead = false
	
func _physics_process(delta):
	
	if State.knife:
		$turn/SokSok/isactive.active = true
	else:
		$turn/SokSok/isactive.active = false
	
	if State.EyePump:
		$Gun1/isactive.active = true
		$bodycol.disabled = false
	else:
		$Gun1/isactive.active = false
		$bodycol.disabled = true
	
	if State.EyePump && State.VisionCompHave:
		$turn/VisionComp.position = Vector2(0, -47)
	elif !State.EyePump && State.VisionCompHave:
		$turn/VisionComp.position = Vector2(0, -20)
	if(Input.is_action_just_pressed("ui_down")):
		position.y += 1
	update_animation()
	if can_move:
		if State.Dash:
			dash()
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
		if !dashing:
			velocity.x = clamp(velocity.x, -speed, speed)
	
	if velocity.x != 0 and is_on_floor() and !$steps.playing:
		$steps.pitch_scale = 1
		$steps.play()
	if($steps.playing and velocity.x == 0):
		$steps.stop()
		$stepsend.play()

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
		#le turno
		$turn.scale.x = sign(velocity.x)
		
		#if statement
		if(anim.animation != "walking"): anim.play("walking")
	if State.VisionCompHave:
		$turn/VisionComp.visible = true
		
func _on_ui_dead():
	if alive:
		var _particle = preload("res://scenes/explosion.tscn").instantiate()
		$labomba.play()
		_particle.position = global_position
		_particle.emitting = true
		get_tree().current_scene.add_child(_particle)
		emit_signal("deadsignal")
		State.apply_random_shake()
		can_move = false
		alive = false
		
func dash():
	if is_on_floor():
		candash = true
	if Input.is_action_just_pressed("Dash") && candash:
		velocity.x = sign(velocity.x) * 2000
		candash = false
		dashing = true
		await get_tree().create_timer(0.2).timeout
		dashing = false
		
	
	
	
	
	
	
