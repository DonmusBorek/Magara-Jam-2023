extends Node2D

signal is_dead

@onready var player:CharacterBody2D = $"../Player"
@onready var timer = $Timer
@onready var rotatet = $Rotatet

var health = 20

var rotation_speed = 0.5
var track = false

var a = false

var alive = true


func _physics_process(delta):
	
	if health == 0 && alive:
		var _particle = preload("res://scenes/explosion.tscn").instantiate()
		_particle.position = global_position
		_particle.emitting = true
		get_tree().current_scene.add_child(_particle)
		emit_signal("is_dead")
		alive = false
		queue_free()
	
	if track:
		rotateToTarget(player, delta)
		if timer.time_left == 0: 
			if !a:
				timer.start(2.5)
			else:
				timer.start(3.0)
		

func rotateToTarget(target, delta):
	var direction = (target.global_position - rotatet.global_position)
	var angleTo = rotatet.global_transform.x.angle_to(direction)
	rotatet.rotate(sign(angleTo) * min(delta * rotation_speed, abs(angleTo)))


func _on_area_2d_area_entered(area):
	if area.is_in_group("Player"):
		track = true
		


func _on_timer_timeout():
	var eyelaser = preload("res://scenes/eyelaser.tscn").instantiate()
	rotatet.add_child(eyelaser)
	a = true
	


func _on_eyecollision_area_entered(area):
	if area.is_in_group("soksokattack") or area.is_in_group("gun"):
		$HitFlash.play("HitFlash")
		health -= 10
