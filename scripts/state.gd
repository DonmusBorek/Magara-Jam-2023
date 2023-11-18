extends Node

var arsenal_opened = 0
var on_arsenal = false

var player
var playerDead

var camera

var VisionCompHave = false
var knife = false
var EyePump = false

var currentWorld = 0
var worldEnd = false
var Worlds = ["res://scenes/Worlds/world_1.tscn", "res://scenes/Worlds/world_2.tscn", "res://scenes/Worlds/world_3.tscn"]
# Called when the node enters the scene tree for the first time


func frameFreeze(timeScale, duration):
	Engine.time_scale = timeScale
	await get_tree().create_timer(duration).timeout
	Engine.time_scale = 1.0
	

# How quickly to move through the noise
var NOISE_SHAKE_SPEED: float = 30.0
var NOISE_SWAY_SPEED: float = 1.0
# Noise returns values in the range (-1, 1)
# So this is how much to multiply the returned value by
var NOISE_SHAKE_STRENGTH: float = 60.0
var NOISE_SWAY_STRENGTH: float = 10.0
# The starting range of possible offsets using random values
var RANDOM_SHAKE_STRENGTH: float = 30.0
# Multiplier for lerping the shake strength to zero
var SHAKE_DECAY_RATE: float = 3.0

enum ShakeType {
	Random,
	Noise,
	Sway
}


@onready var noise = FastNoiseLite.new()
# Used to keep track of where we are in the noise
# so that we can smoothly move through it
var noise_i: float = 0.0
@onready var rand = RandomNumberGenerator.new()
var shake_type: int = ShakeType.Random
var shake_strength: float = 0.0

var cam_offset

func _ready() -> void:
	rand.randomize()
	
	# Randomize the generated noise
	noise.seed = rand.randi()
	# Period affects how quickly the noise changes values
	noise.frequency = 0.5
	
	
	
func apply_random_shake() -> void:
	shake_strength = RANDOM_SHAKE_STRENGTH
	shake_type = ShakeType.Random
	
func apply_noise_shake() -> void:
	shake_strength = NOISE_SHAKE_STRENGTH
	shake_type = ShakeType.Noise
	
func apply_noise_sway() -> void:
	shake_type = ShakeType.Sway
	
func _process(delta: float) -> void:
	if(knife):
		player.get_node("turn/SokSok/isactive").active = true
	else:
		player.get_node("turn/SokSok/isactive").active = false
		
	# Fade out the intensity over time
	shake_strength = lerp(shake_strength, 0.0, SHAKE_DECAY_RATE * delta)
	
	var shake_offset: Vector2
	
	match shake_type:
		ShakeType.Random:
			shake_offset = get_random_offset()
		ShakeType.Noise:
			shake_offset = get_noise_offset(delta, NOISE_SHAKE_SPEED, shake_strength)
		ShakeType.Sway:
			shake_offset = get_noise_offset(delta, NOISE_SWAY_SPEED, NOISE_SWAY_STRENGTH)
	
	# Shake by adjusting camera.offset so we can move the camera around the level via it's position
	cam_offset = shake_offset

func get_noise_offset(delta: float, speed: float, strength: float) -> Vector2:
	noise_i += delta * speed
	# Set the x values of each call to 'get_noise_2d' to a different value
	# so that our x and y vectors will be reading from unrelated areas of noise
	return Vector2(
		noise.get_noise_2d(1, noise_i) * strength,
		noise.get_noise_2d(100, noise_i) * strength
	)

func get_random_offset() -> Vector2:
	return Vector2(
		rand.randf_range(-shake_strength, shake_strength),
		rand.randf_range(-shake_strength, shake_strength)
	)
