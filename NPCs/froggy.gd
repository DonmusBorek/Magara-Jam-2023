extends CharacterBody2D

var state = "alive"
var atstate = 3
var can_move = true
var speed = 0
var attack = 34
var mass = 8
var health = 300
var jumponce = true
var jumponce2 = true
var overwall = true
var fall = false
const JUMP_VELOCITY = -400.0

@onready var anima = $turn/anima
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	$turn/Hurtful.attack = attack
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if($rcL.is_colliding() || $rcR.is_colliding()):
		if(overwall):
			$shuffletimer.stop()
			print(atstate)
			atstate = 3
			anima.play("jump")
			overwall = false
	if(state == "alive") && can_move:
		match atstate:
			0:
				#run
				anima.speed_scale = 2
				if(!anima.is_playing()): anima.pause()
				if(anima.animation != "walk"): anima.play("walk")
				if(State.player.global_position.x < position.x):
					var tween = get_tree().create_tween()
					tween.tween_property(self, "speed", -300, 2)
				else:
					var tween = get_tree().create_tween()
					tween.tween_property(self, "speed", +300, 2)
				velocity.x = speed
			1:
				#walk
				if(!anima.is_playing()): anima.pause()
				if(anima.animation != "walk"): anima.play("walk")
				if(State.player.global_position.x < position.x):
					var tween = get_tree().create_tween()
					tween.tween_property(self, "speed", -100, 2)
				else:
					var tween = get_tree().create_tween()
					tween.tween_property(self, "speed", 100, 2)
				velocity.x = speed
			2:
				#recoil
				velocity.y = -50
				if($recotimer.is_stopped()): $recotimer.start()
			3:
				if(jumponce):
					anima.play("jump")
					jumponce = false
					$realjumptimer.start()
				if(anima.animation == "jump" && anima.frame == 9 && jumponce2):
					anima.pause()
					var distance = State.player.global_position.x - position.x
					var height = abs(State.player.global_position.y - position.y - 32)
					velocity.x = distance
					velocity.y = -400
					jumponce2 = false
					$jumptimer.start()
				if(anima.animation == "jump" && anima.frame == 9 && is_on_floor() && fall):
					$shuffletimer.start()
					fall = false
	#Le Turno
	if(velocity.x == 0): scale.x = 1
	if(velocity.x >= 0):
		anima.flip_h = true
	else:
		anima.flip_h = false
	print(atstate)
	move_and_slide()

func _on_hurtful_body_entered(body):
	if(body == State.player):
		atstate = 2 #recoil
	pass # Replace with function body.

func _on_recotimer_timeout():
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
	$shuffletimer.start()
	pass # Replace with function body.


func _on_realjumptimer_timeout():
	jumponce = true
	jumponce2 = true
	pass # Replace with function body.
