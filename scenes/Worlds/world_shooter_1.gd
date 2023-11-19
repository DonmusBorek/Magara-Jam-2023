extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$"Player".health = 200
	$Player/UI/HPBar.max_value = 200


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_area_entered(area):
	if area.is_in_group("Player"):
		$CanvasLayer/ackapa/Fadeout1.play("fadeout")
		await get_tree().create_timer(3).timeout
		get_tree().change_scene_to_file("res://scenes/Worlds/boss_room.tscn")
