extends Control

var timer: Timer
@onready var camera = $Camera2D

var faded = false
var onayarlar = false
# Called when the node enters the scene tree for the first time.
func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = 1
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)
	camera.global_position = Vector2(481,271)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_oyna_toggled(button_pressed):
	pass # Replace with function body.


func _on_ayarlar_toggled(button_pressed):
	if button_pressed:
		$Fade.play("fade")
		faded = true
		timer.start()
		#481 271


func _on_cıkıs_toggled(button_pressed):
	get_tree().quit()


func _on_fade_animation_finished(anim_name):
	if faded:
		$Fade.play_backwards("fade")
		faded = false

func _on_timer_timeout():
	if !onayarlar:
		camera.global_position = Vector2(1647,271)
		onayarlar = true
	elif onayarlar:
		camera.global_position = Vector2(481,271)
		onayarlar = false


func _on_check_button_toggled(button_pressed):
	if button_pressed:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	if !button_pressed:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_geri_toggled(button_pressed):
	if button_pressed:
		$Fade.play("fade")
		faded = true
		timer.start()
		
