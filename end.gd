extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	State.on_end = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_end_label_display_finished():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
