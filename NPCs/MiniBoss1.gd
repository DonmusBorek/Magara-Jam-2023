extends CharacterBody2D

var state = "alive"
var speed = 50
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var turned = false
var attack = 50
var playerinsight

func _ready():
	$marker/Hurtful.attack = 50
	
func _physics_process(delta):
	if(state == "alive"):
		if(State.player.global_position.x < position.x):
			var tween = get_tree().create_tween()
			tween.tween_property(self, "speed", -300, 2)
		else:
			var tween = get_tree().create_tween()
			tween.tween_property(self, "speed", +300, 2)
		velocity.x = speed
	if not is_on_floor():
		velocity.y += gravity * delta

	if(sign(velocity.x) < 0):
		$marker.scale.x = 1
	else:
		$marker.scale.x = -1
		
	if(!playerinsight && $marker/Ust.frame == 7):
		$marker/Ust.stop()
	
	if($marker/Ust.frame == 4):
		$marker/Hurtful/CollisionShape2D.disabled = false
	else:
		$marker/Hurtful/CollisionShape2D.disabled = true
	move_and_slide()

func _on_detector_body_entered(body):
	if(body == State.player):
		$marker/Ust.play("default")
		playerinsight = true
	pass # Replace with function body.

func _on_detector_body_exited(body):
	if(body == State.player):
		playerinsight = false
	pass # Replace with function body.
