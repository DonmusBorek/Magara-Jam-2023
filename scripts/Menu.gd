extends Control

@onready var camera = $Camera2D

var faded = false
var onayarlar = false
var ayarlaradogru = false
var basadogru = false
# Called when the node enters the scene tree for the first time.
func _ready():
	State.on_menu = true
	camera.global_position = Vector2(0,0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(camera.position == Vector2(1174, 0)):
		if(faded) && !basadogru:
			$Fade.play_backwards("fade")
			faded = false
	elif(camera.position == Vector2(0, 0)):
		if(faded && !ayarlaradogru):
			$Fade.play_backwards("fade")
			faded = false
	pass


func _on_oyna_toggled(button_pressed):
	get_tree().change_scene_to_file("res://scenes/intro.tscn")
	pass # Replace with function body.


func _on_ayarlar_toggled(button_pressed):
	if button_pressed:
		$Fade.play("fade")
		ayarlaradogru = true
		faded = true


func _on_cıkıs_toggled(button_pressed):
	get_tree().quit()


func _on_check_button_toggled(button_pressed):
	if button_pressed:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	if !button_pressed:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_geri_toggled(button_pressed):
	if button_pressed:
		$Fade.play("fade")
		faded = true
		basadogru = true
		
func _on_master_2_value_changed(value):
	volume(0,value)

func volume(bus_index, value):
	
	AudioServer.set_bus_volume_db(bus_index,value)
	


func _on_music_value_changed(value):
	volume(2,value)


func _on_sfx_value_changed(value):
	volume(1,value)


func _on_fade_animation_finished(anim_name):
	if(ayarlaradogru):
		var tween = get_tree().root.create_tween().set_ease(Tween.EASE_OUT)
		tween.tween_property(camera, "position", Vector2(1174, 0), 1)
		ayarlaradogru = false
	if(basadogru):
		var tween = get_tree().root.create_tween().set_ease(Tween.EASE_OUT)
		tween.tween_property(camera, "position", Vector2(0, 0), 1)
		basadogru = false
	pass # Replace with function body.
