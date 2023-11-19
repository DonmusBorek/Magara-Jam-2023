extends Node2D

@onready var player = $Player
@onready var camera = $Camera2D

var end = false

var a = 0
var b = true

# Called when the node enters the scene tree for the first time.
func _ready():
	State.currentWorld = 9


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player.global_position.x - camera.global_position.x > 480 && player.global_position.x < 960:
		camera.global_position.x += 480
	elif player.global_position.x - camera.global_position.x < 0:
		camera.global_position.x -= 480
	
	if a == 3 && b:
		$Door._door_open()
		b = false



func _on_area_2d_area_entered(area):
	if area.is_in_group("Player"):
		$CanvasLayer/ackapa/Fadeout1.play("fadeout")
		await get_tree().create_timer(3).timeout
		get_tree().change_scene_to_file("res://scenes/Worlds/world_10.tscn")




func _on_player_deadsignal():
	$CanvasLayer/ackapa/Fadeout1.play("fadeout")
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://scenes/Worlds/world_9.tscn")




func _on_mini_boss_1_bossdead():
	a += 1


func _on_mini_boss_2_bossdead():
	a += 1


func _on_doorbutton_area_entered(area):
	a += 1
