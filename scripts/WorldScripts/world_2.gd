extends Node2D

var squish1 = false
var squish2 = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if squish1 && squish2:
		print("robertodead")


func _on_platformdetect_area_entered(area):
	if area.is_in_group("Player"):
		$Platformanim.play("platform")


func _on_platformdetect_area_exited(area):
	if area.is_in_group("Player"):
		$Platformanim.play_backwards("platform")


func _on_squish_area_entered(area):
	if area.is_in_group("Player"):
		squish1 = true


func _on_squish_2_area_entered(area):
	if area.is_in_group("Player"):
		squish2 = true


func _on_area_2d_area_entered(area):
	if area.is_in_group("Player"):
		print("nextworld")
