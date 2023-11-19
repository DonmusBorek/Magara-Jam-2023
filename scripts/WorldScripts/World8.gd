extends Node2D

@onready var player = $Player

var end = false

# Called when the node enters the scene tree for the first time.
func _ready():
	State.currentWorld = 8


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_area_2d_area_entered(area):
	if area.is_in_group("Player"):
		$CanvasLayer/ackapa/Fadeout1.play("fadeout")
		await get_tree().create_timer(3).timeout
		get_tree().change_scene_to_file("res://scenes/upgrade_station.tscn")




func _on_player_deadsignal():
	$CanvasLayer/ackapa/Fadeout1.play("fadeout")
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://scenes/Worlds/world_8.tscn")




func _on_eye_is_dead():
	$Door._door_open()
