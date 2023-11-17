extends Control

var a = true
var geri = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if State.VisionCompHave && a:
		$Control/head.visible = true
		$World3timer.start()
		a = false
		

func  fadeout():
	$Marker2D/Fadeout.play("fadeot")
	geri = false


func _on_fadeout_animation_finished(anim_name):
	if !geri:
		$"../../Player".can_move = false
		$texttimer.start()
	else:
		$"../../Player".can_move = true

func _on_world_3_timer_timeout():
	
	$Marker2D/Fadeout.play_backwards("fadeot")
	geri = true
