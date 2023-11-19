extends Node2D

@onready var camera = $Camera2D
@onready var player = $Player

var end = false

# Called when the node enters the scene tree for the first time.
func _ready():
	State.currentWorld = 5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player.global_position.x - camera.global_position.x > 480 && player.global_position.x < 960:
		camera.global_position.x += 480
	elif player.global_position.x - camera.global_position.x < 0:
		camera.global_position.x -= 480


func _on_area_2d_area_entered(area):
	if area.is_in_group("Player"):
		$CanvasLayer/ackapa/Fadeout1.play("fadeout")
		await get_tree().create_timer(3).timeout
		get_tree().change_scene_to_file("res://scenes/Worlds/world_6.tscn")



func _on_player_deadsignal():
	$CanvasLayer/ackapa/Fadeout1.play("fadeout")
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://scenes/Worlds/world_5.tscn")
