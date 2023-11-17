extends Node2D

var cooldown = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	$Marker2D.look_at(get_global_mouse_position())
	
	if(get_global_mouse_position().x < global_position.x):
		$Marker2D/Sprite2D.flip_v = true
	else:
		$Marker2D/Sprite2D.flip_v = false
	if(Input.is_action_pressed("Left_Click")):
		if(!cooldown):
			var bullet = preload("res://player_bullet.tscn").instantiate()
			bullet.global_position = $Marker2D/gunpoint.global_position
			bullet.global_rotation_degrees = $Marker2D.global_rotation_degrees
			get_tree().root.add_child(bullet)
			cooldown = true
			var sfx = preload("res://scenes/gunshotsfx.tscn").instantiate()
			add_child(sfx)
			$cd.start()
			if($Marker2D/guncast.is_colliding()):
				if($Marker2D/guncast.get_collider().is_in_group("Enemy")):
					$Marker2D/guncast.get_collider().health -= 1
					var hitenemy = preload("res://hit_enemy.tscn").instantiate()
					hitenemy.global_position = $Marker2D/guncast.get_collision_point()
					get_tree().root.add_child(hitenemy)
					print("shit")
func _on_cd_timeout():
	cooldown = false
	pass # Replace with function body.
