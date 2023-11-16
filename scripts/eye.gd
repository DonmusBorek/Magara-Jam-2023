extends Node2D

@onready var player:CharacterBody2D = $"../Player"
@onready var timer = $Timer
@onready var rotatet = $Rotatet



var rotation_speed = 1.0
var track = false


func _physics_process(delta):
		
	if track:
		rotateToTarget(player, delta)
		if timer.time_left == 0: 
			timer.start()
		

func rotateToTarget(target, delta):
	var direction = (target.global_position - rotatet.global_position)
	var angleTo = rotatet.transform.x.angle_to(direction)
	rotatet.rotate(sign(angleTo) * min(delta * rotation_speed, abs(angleTo)))


func _on_area_2d_area_entered(area):
	if area.is_in_group("Player"):
		track = true
		


func _on_timer_timeout():
	var eyelaser = preload("res://scenes/eyelaser.tscn").instantiate()
	rotatet.add_child(eyelaser)
	
