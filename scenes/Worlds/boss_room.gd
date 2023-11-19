extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	State.VisionCompHave = true
	State.EyePump = true
	State.Dash = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_froggy_bossdead():
	$Door._door_open()


func _on_elevin_area_entered(area):
	if area.is_in_group("Player"):
		$end.play("end")






func _on_endarea_area_entered(area):
	if area.is_in_group("Player"):
		pass
