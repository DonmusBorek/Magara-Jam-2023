extends Node

var arsenal_opened = 0

var player
var playerDead
var VisionCompHave = false
var currentWorld
var worldEnd = false
var Worlds = ["res://scenes/Worlds/world_1.tscn", "res://scenes/Worlds/world_2.tscn", "res://scenes/Worlds/world_3.tscn"]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func frameFreeze(timeScale, duration):
	Engine.time_scale = timeScale
	await get_tree().create_timer(duration).timeout
	Engine.time_scale = 1.0
