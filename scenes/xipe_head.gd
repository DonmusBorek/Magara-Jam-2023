extends CharacterBody2D

var rng = RandomNumberGenerator.new()
var speed = 0
var health = 240
var attack = 25
# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if(State.player.position.x < position.x):
		var tween = get_tree().create_tween()
		tween.tween_property(self, "velocity", Vector2(-50, velocity.y), 1)
	else:
		var tween = get_tree().create_tween()
		tween.tween_property(self, "velocity", Vector2(50, velocity.y), 1)
		
	if(State.player.position.y - 125 < position.y):
		var tween = get_tree().create_tween()
		tween.tween_property(self, "velocity", Vector2(velocity.x, -50), 1)
	else:
		var tween = get_tree().create_tween()
		tween.tween_property(self, "velocity", Vector2(velocity.x, 50), 1)
	
	if(health <= 60):
		$FirstForm.visible = false
		$SecondForm.visible = true
		$FirstCollider.disabled = true
		$SecondCollider.disabled = false
		$AudioStreamPlayer.pitch_scale = 0.8
	if(health == 0):
		get_tree().change_scene_to_file("res://iknow.tscn")
	move_and_slide()
	pass


func _on_timer_timeout():
	if($SummoningSickness.time_left == 0):
		if(health >= 60):
			var tear = preload("res://tear.tscn").instantiate()
			tear.position = Vector2(position.x-90, position.y-100)
			get_tree().current_scene.add_child(tear)
			var tear2 = preload("res://tear.tscn").instantiate()
			tear2.position = Vector2(position.x+120, position.y-100)
			get_tree().current_scene.add_child(tear2)
		else:
			for n in 8:
				var essence = preload("res://essence.tscn").instantiate()
				var rng = RandomNumberGenerator.new()
				essence.position = Vector2(rng.randi_range(position.x-60, position.x+60), position.y-60)
				get_tree().current_scene.add_child(essence)
	else:
		var tween = get_tree().create_tween()
		tween.tween_property($FirstForm, "modulate", Color(1, 1, 1, 1), 2.5)
	pass # Replace with function body.
