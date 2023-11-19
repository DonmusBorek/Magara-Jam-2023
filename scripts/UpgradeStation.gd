extends Control

var a = true
var geri = false

var onworld3 = false

var can_devam = false
# Called when the node enters the scene tree for the first time.
func _ready():
	if State.VisionCompHave:
		$Control/Objects/vision.position = $Control/Placable/Head.position
	if State.knife:
		$Control/Objects/knife.position = $Control/Placable/Right_Hand.position
	if State.EyePump:
		$Control/Objects/pump.position = $Control/Placable/Left_Hand.position
	if State.Dash:
		$Control/Objects/dash.position = $Control/Placable/Ability.position
	
	
	if get_parent().get_parent() != null:
		onworld3 = true
	
	if !onworld3:
		State.on_arsenal = true
		fadeout()
		await get_tree().create_timer(3).timeout
		$texttimer.start()
	if State.currentWorld == 8:
		$Control/Objects/pump.visible = true
	if State.currentWorld == 10:
		$Control/Objects/dash.visible = true
		$Control/Objects/pump.visible = true


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
	if can_devam:
		if onworld3:
			if State.VisionCompHave && State.knife:
				$CanvasLayer/ackapa/Fadeout1.play("fadeout")
				await get_tree().create_timer(3).timeout
				$CanvasLayer/ackapa/Fadeout1.play_backwards("fadeout")
				$Control.visible = false
				$"../AIworld".visible = true
				$"../../Player".can_move = true
		elif State.currentWorld == 8:
			if State.EyePump:
				$CanvasLayer/ackapa/Fadeout1.play("fadeout")
				await get_tree().create_timer(3).timeout
				get_tree().change_scene_to_file(State.Worlds[State.currentWorld+1])
		elif State.currentWorld == 10:
			if State.Dash:
				$CanvasLayer/ackapa/Fadeout1.play("fadeout")
				await get_tree().create_timer(3).timeout
				get_tree().change_scene_to_file(State.Worlds[State.currentWorld+1])


func _on_a_itext_display_finished():
	can_devam =  true
