extends CharacterBody2D

var isfroggy = 1
var mass = 0.2
var health = 1000
var attack = 10
var state = "alive"
var can_move = false
var can_can_move = false
var speed = 10

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
func _ready():
	$Hurtful.attack = attack

func _physics_process(delta):
	if(can_can_move && State.player.can_move):
		can_move = true
		
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if(health <= 0): state = "dead"
	if(state == "alive" && can_move && !$HitFlash.is_playing()):
		if(State.player.global_position.x < position.x):
			var tween = get_tree().create_tween()
			tween.tween_property(self, "speed", -500, 3)
		else:
			var tween = get_tree().create_tween()
			tween.tween_property(self, "speed", +500, 3)
		velocity.x = speed
		#Le Turno
		if(sign(velocity.x) < 0):
			$marker.scale.x = 1
		else:
			$marker.scale.x = -1
	elif (state == "dead"):
		modulate = Color.DIM_GRAY
	# Add the gravity.
	move_and_slide()


func _on_jumptimer_timeout():
	velocity.y = -200
	velocity.x *= 1.2
	$jumptimer.wait_time = randf_range(0.8, 3)
	$jumptimer.start()
	pass # Replace with function body.


func _on_player_detector_body_entered(body):
	if(body == State.player):
		can_can_move = true
	pass # Replace with function body.
