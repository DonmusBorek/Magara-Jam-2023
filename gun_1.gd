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
			
			#Shoot
			var bullet = preload("res://player_bullet.tscn").instantiate()
			bullet.global_position = $Marker2D/gunpoint.global_position
			bullet.global_rotation_degrees = $Marker2D.global_rotation_degrees
			get_tree().root.add_child(bullet)
			
			#Recoil
			State.player.velocity -= ($Marker2D/guncast.global_position-State.player.global_position).normalized() * 300
			
			#sfx
			var sfx = preload("res://scenes/gunshotsfx.tscn").instantiate()
			add_child(sfx)
			
			#Shot
			$Marker2D/Shot.visible = true
			$Marker2D/Light.enabled = true
			
			#Hitscan
			if($Marker2D/guncast.is_colliding()):
				if $Marker2D/guncast.get_collider().is_in_group("eye"):
					$Marker2D/guncast.get_collider().health -= 5
					$Marker2D/guncast.get_collider().get_node("HitFlash").play("HitFlash")
				
				var hitenemy = preload("res://hit_enemy.tscn").instantiate()
				hitenemy.global_position = $Marker2D/guncast.get_collision_point()
				get_tree().root.add_child(hitenemy)
				if($Marker2D/guncast.get_collider().is_in_group("Enemy")):
					$Marker2D/guncast.get_collider().health -= 2
					$Marker2D/guncast.get_collider().get_node("HitFlash").play("HitFlash2")
					$Marker2D/guncast.get_collider().velocity -= (State.player.global_position-$Marker2D/guncast.get_collider().global_position).normalized() * 800 * $Marker2D/guncast.get_collider().isfroggy / $Marker2D/guncast.get_collider().mass
					var kivilcim = preload("res://scenes/kivilcim.tscn").instantiate()
					kivilcim.rotation_degrees = $Marker2D.rotation_degrees
					kivilcim.global_position = $Marker2D/guncast.get_collision_point()
					get_tree().root.add_child(kivilcim)
					print("shit")
			#cooldown
			cooldown = true
			$cd.start()
		else:
			$Marker2D/Shot.visible = false
			$Marker2D/Light.enabled = false
func _on_cd_timeout():
	cooldown = false
	pass # Replace with function body.
