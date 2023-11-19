extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	State.currentWorld = 13
	
	State.VisionCompHave = true
	State.EyePump = true
	State.Dash = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_froggy_bossdead():
	$Door._door_open()
	$AudioStreamPlayer.stop()




func _on_area_2d_area_entered(area):
	if area.is_in_group("Player"):
		$end.play("end")


func _on_end_animation_finished(anim_name):
	get_tree().change_scene_to_file("res://end.tscn")
