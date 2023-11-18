extends Node2D

@onready var player = $Player

var end = false
var a = true
var buttonactive = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if buttonactive == 4 && a:
		$Door._door_open()
		a = false
		



func _on_area_2d_area_entered(area):
	if area.is_in_group("Player"):
		$CanvasLayer/Marker2D/Fadeout1.play("fadeout")


func _on_fadeout_1_animation_finished(anim_name):
	if !player.alive:
		get_tree().change_scene_to_file("res://scenes/Worlds/world_4_2.tscn")
	elif end:
		get_tree().change_scene_to_file("res://scenes/Worlds/world_5.tscn")

	else:
		end = true



func _on_player_deadsignal():
	$CanvasLayer/Marker2D/Fadeout1.play("fadeout")



func _on_doorbutton_area_entered(area):
	if area.is_in_group("Player"):
		buttonactive += 1


func _on_doorbutton_2_area_entered(area):
	if area.is_in_group("Player"):
		buttonactive += 1


func _on_doorbutton_3_area_entered(area):
	if area.is_in_group("Player"):
		buttonactive += 1


func _on_doorbutton_4_area_entered(area):
	if area.is_in_group("Player"):
		buttonactive += 1
