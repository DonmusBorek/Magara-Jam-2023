extends CharacterBody2D

const SPEED = 2000

func _ready():
	velocity = (get_global_mouse_position() - global_position).normalized() * SPEED
func _physics_process(delta):
	modulate.a += 0.5
	# Add the gravity.
	move_and_slide()
func _on_enemy_detector_body_entered(body):
	if(body.is_in_group("Enemy")):
		queue_free()
	pass # Replace with function body.
