extends Node2D

@onready var camera = $Camera2D
@onready var player = $Player

var opened = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer/ackapa/Fadeout1.play_backwards("fadeout")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player.global_position.x - camera.global_position.x > 480 && player.global_position.x < 960:
		camera.global_position.x += 480
	elif player.global_position.x - camera.global_position.x < 0:
		camera.global_position.x -= 480


func _on_area_2d_area_entered(area):
	State.worldEnd = true
	if(area == State.player.get_node("Area2D")):
		player.can_move = false
		$CanvasLayer/ackapa/Fadeout1.play("fadeout")


func _on_fadeout_1_animation_finished(anim_name):
	if opened:
		State.currentWorld = 1
		get_tree().change_scene_to_file("res://scenes/Worlds/world_2.tscn")
	else:
		opened = true
