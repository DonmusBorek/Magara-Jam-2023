extends Node2D

@onready var player = $Player

var end = false
var a = true
var buttonactive = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	State.currentWorld = 4


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if buttonactive == 4 && a:
		$Door._door_open()
		a = false
		



func _on_area_2d_area_entered(area):
	if area.is_in_group("Player"):
		$CanvasLayer/ackapa/Fadeout1.play("fadeout")
		await get_tree().create_timer(3).timeout
		get_tree().change_scene_to_file("res://scenes/Worlds/world_5.tscn")




func _on_player_deadsignal():
	$CanvasLayer/ackapa/Fadeout1.play("fadeout")
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://scenes/Worlds/world_4_2.tscn")



func _on_doorbutton_area_entered(area):
	if area.is_in_group("soksokattack"):
		buttonactive += 1


func _on_doorbutton_2_area_entered(area):
	if area.is_in_group("soksokattack"):
		buttonactive += 1


func _on_doorbutton_3_area_entered(area):
	if area.is_in_group("soksokattack"):
		buttonactive += 1


func _on_doorbutton_4_area_entered(area):
	if area.is_in_group("soksokattack"):
		buttonactive += 1
