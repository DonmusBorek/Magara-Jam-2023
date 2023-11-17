extends Node2D

@onready var camera = $Camera2D
@onready var player = $Player

var squish1 = false
var squish2 = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player.global_position.x - camera.global_position.x > 480:
		camera.global_position.x += 480
	elif player.global_position.x - camera.global_position.x < 0:
		camera.global_position.x -= 480
		
	if squish1 && squish2:
		$Platformanim.pause()
		$MiniBoss1.state = "dead"
		squish1 = false


func _on_platformdetect_area_entered(area):
	if area.is_in_group("Player"):
		$Platformanim.speed_scale = 1.0
		$Platformanim.play("platform")



func _on_platformdetect_area_exited(area):
	if area.is_in_group("Player"):
		$Platformanim.speed_scale = 3.0
		$Platformanim.play_backwards("platform")


func _on_squish_2_area_entered(area):
	if area.is_in_group("Player"):
		print("robededdo")



func _on_squish_1_body_entered(body):
	if body.is_in_group("Enemy"):
		squish1 = true


func _on_squish_2_body_entered(body):
	if body.is_in_group("Enemy"):
		squish2 = true


func _on_eyegain_area_entered(area):
	if area.is_in_group("Player"):
		
		$CanvasLayer/UpgradeStation.visible = true
		$CanvasLayer/UpgradeStation.fadeout()
