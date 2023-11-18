extends CharacterBody2D

var state = "alive"
var atstate = 3
var can_move = true
var speed = 0
var attack = 34
var mass = 80
var health = 300
var jumponce = true
var jumponce2 = true
var overwall = true
var fall = false
var hitbody = false
var isfroggy = 0
const JUMP_VELOCITY = -400.0

@onready var anima = $turn/anima
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * 0.7

func _ready():
	$turn/Hurtful.attack = attack
func _physics_process(delta):
	print(State.player.velocity.x)
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if($rcL.is_colliding() || $rcR.is_colliding()):
		if(overwall):
			$shuffletimer.stop()
			print(atstate)
			atstate = 3
			overwall = false
	if(state == "alive") && can_move:
		match atstate:
			0:
				#run
				anima.speed_scale = 2
				if(anima.animation != "walk"): anima.play("walk")
				if(State.player.global_position.x < position.x):
					var tween = get_tree().create_tween()
					tween.tween_property(self, "speed", -600, 2)
				else:
					var tween = get_tree().create_tween()
					tween.tween_property(self, "speed", +600, 2)
				velocity.x = speed
			1:
				#walk
				if(anima.animation != "walk"): anima.play("walk")
				if(State.player.global_position.x < position.x):
					var tween = get_tree().create_tween()
					tween.tween_property(self, "speed", -300, 2)
				else:
					var tween = get_tree().create_tween()
					tween.tween_property(self, "speed", 300, 2)
				velocity.x = speed
			2:
				#recoil
				velocity.y = -50
				if($recotimer.is_stopped()): $recotimer.start()
			3:
				if(jumponce):
					velocity.x = 0
					anima.play("jump")
					jumponce = false
					$realjumptimer.start()
				if(anima.animation == "jump" && anima.frame == 6 && jumponce2):
					if(anima.frame == 9): anima.pause()
					var distance = State.player.global_position.x - global_position.x
					var height = abs(State.player.global_position.y - position.y - 64)
					velocity.x = distance + State.player.velocity.x * 40 * delta
					velocity.y = -450 - height
					jumponce2 = false
					$jumptimer.start()
				if(anima.animation == "jump" && anima.frame == 9 && is_on_floor() && fall):
					anima.play("walk")
					$shuffletimer.start()
					atstate = 1
					fall = false
	#Le Turno
	if(velocity.x == 0):
		if(State.player.global_position.x < position.x):
			anima.flip_h = false
		else:
			anima.flip_h = true
	if(velocity.x < 0):
		anima.flip_h = false
	elif(velocity.x > 0):
		anima.flip_h = true
	move_and_slide()

func _on_hurtful_body_entered(body):
	if(body == State.player):
		hitbody = true
		atstate = 3 #recoil
	pass # Replace with function body.

func _on_recotimer_timeout():
	print("reeeecoooiiiiilllll!")
	atstate = 0
	pass # Replace with function body.


func _on_jumptimer_timeout():
	overwall = true
	fall = true
	pass # Replace with function body.


func _on_shuffletimer_timeout():
	var attacks = [0, 1, 3]
	atstate = attacks[randi_range(0, 2)]
	$shuffletimer.wait_time = randf_range(3, 8)
	pass # Replace with function body.


func _on_realjumptimer_timeout():
	jumponce = true
	jumponce2 = true
	pass # Replace with function body.


func _on_hurtful_body_exited(body):
	if(body == State.player):
		hitbody = false
		atstate = 4
	pass # Replace with function body.
