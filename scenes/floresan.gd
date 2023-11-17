extends Node2D

var enabled = true

func _ready():
	pass

func _process(delta):
	if(enabled):
		$acik.visible = true
		$kapali.visible = false
		if($kivilcimcikarici.is_stopped()): $kivilcimcikarici.start()
		$light.enabled = true
		if(!$sfx.playing): $sfx.play()
	else:
		$acik.visible = false
		$kapali.visible = true
		$kivilcimcikarici.stop()
		$light.enabled = false
		$sfx.stop()

func _on_timer_timeout():
	enabled = !enabled
	$Timer.wait_time = randf_range(0.1, 4)
	$Timer.start()


func _on_kivilcimcikarici_timeout():
	print("kivilced")
	var kivilcim = preload("res://scenes/kivilcim.tscn").instantiate()
	kivilcim.rotation_degrees = 90
	kivilcim.global_position = self.global_position
	get_tree().root.add_child(kivilcim)
	$kivilcimcikarici.wait_time = randf_range(0.1, 1)
	$kivilcimcikarici.start()
	pass # Replace with function body.
