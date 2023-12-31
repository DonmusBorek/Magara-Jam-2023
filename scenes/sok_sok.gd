extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("Right_Click")):
		$anima.play("default")
	if($anima.frame == 3 or $anima.frame == 4 or $anima.frame == 5 or $anima.frame == 6):
		$Attack/CollisionShape2D.disabled = false
	else:
		$Attack/CollisionShape2D.disabled = true
	pass

func _on_attack_body_entered(body):
	if(body.is_in_group("Enemy")):
		body.health -= 10
		body.get_node("HitFlash").play("HitFlash2")
		body.speed -= (State.player.global_position.x-body.global_position.x) * 20 * body.isfroggy / body.mass
		State.frameFreeze(0.1, 0.05)
		var kivilcim = preload("res://scenes/kivilcim.tscn").instantiate()
		kivilcim.rotation_degrees = rotation_degrees
		kivilcim.global_position = Vector2(global_position.x+5, global_position.y)
		get_tree().root.add_child(kivilcim)
	pass # Replace with function body.
