extends Control

var a = true
var geri = false

var onworld3 = false
# Called when the node enters the scene tree for the first time.
func _ready():
	if get_parent().get_parent() != null:
		onworld3 = true
	
	if !onworld3:
		State.on_arsenal = true
		fadeout()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if State.VisionCompHave:
		$Control/head.visible = true
	if !State.VisionCompHave && !onworld3:
		$Control/head.visible = false
		

func  fadeout():
	$CanvasLayer/ackapa/Fadeout1.play_backwards("fadeout")
	if !onworld3:
		$CanvasLayer/ackapa/Fadeout1.seek(2.5,true)
	geri = false


func _on_fadeout_animation_finished(anim_name):
	if onworld3:
		if !geri:
			State.player.can_move = false
			$texttimer.start()
		else:
			State.player.can_move = true
	else:
		pass



func _on_next_pressed():
	if onworld3:
		if State.VisionCompHave && State.knife:
			$CanvasLayer/ackapa/Fadeout1.play("fadeout")
			await get_tree().create_timer(3).timeout
			$CanvasLayer/ackapa/Fadeout1.play_backwards("fadeout")
			$Control.visible = false
			$"../../Player".can_move = true
	else:
		$CanvasLayer/ackapa/Fadeout1.play("fadeout")
		await get_tree().create_timer(3).timeout
		#targescene
