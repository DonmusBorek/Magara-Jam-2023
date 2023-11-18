extends CharacterBody2D

signal bossdead

var state = "alive"
var speed = 50
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var turned = false
var health = 20
var attack = 50
var playerinsight
var mass = 1

var can_move = false

func _ready():
	$marker/Hurtful.attack = 50
	
func _physics_process(delta):
	if(health <= 0): state = "dead"
	if(state == "alive") && can_move:
		if(State.player.global_position.x < position.x):
			var tween = get_tree().create_tween()
			tween.tween_property(self, "speed", -300, 2)
		else:
			var tween = get_tree().create_tween()
			tween.tween_property(self, "speed", +300, 2)
		velocity.x = speed
		#Le Turno
		if(sign(velocity.x) < 0):
			$marker.scale.x = 1
		else:
			$marker.scale.x = -1
	elif (state == "dead"):
		modulate = Color.DIM_GRAY
			
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if(!playerinsight && $marker/Ust.frame == 7):
		$marker/Ust.stop()
	
	if($marker/Ust.frame == 4):
		$marker/Hurtful/CollisionShape2D.disabled = false
	else:
		$marker/Hurtful/CollisionShape2D.disabled = true
	move_and_slide()
	
	if state == "dead":
		var _particle = preload("res://scenes/explosion.tscn").instantiate()
		_particle.position = global_position
		_particle.emitting = true
		get_tree().current_scene.add_child(_particle)
		emit_signal("bossdead")
		queue_free()

func _on_detector_body_entered(body):
	if(state == "alive"):
		if(body == State.player):
			$marker/Ust.play("default")
			playerinsight = true
	pass # Replace with function body.

func _on_detector_body_exited(body):
	if(state == "alive"):
		if(body == State.player):
			playerinsight = false
	pass # Replace with function body.


func _on_detection_area_entered(area):
	if area.is_in_group("Player"):
		can_move = true
