extends Node2D

@onready var camera = $Camera2D
@onready var player = $Player

var end = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player.global_position.x - camera.global_position.x > 480 && player.global_position.x < 960:
		camera.global_position.x += 480
	elif player.global_position.x - camera.global_position.x < 0:
		camera.global_position.x -= 480


func _on_area_2d_area_entered(area):
	if area.is_in_group("Player"):
		$CanvasLayer/Marker2D/Fadeout1.play("fadeout")


func _on_fadeout_1_animation_finished(anim_name):
	if !player.alive:
		get_tree().change_scene_to_file("res://scenes/Worlds/world_6.tscn")
	elif end:
		get_tree().change_scene_to_file("res://scenes/Worlds/world_7.tscn")

	else:
		end = true


func _on_player_deadsignal():
	$CanvasLayer/Marker2D/Fadeout1.play("fadeout")
