extends Control
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func  fadeout():
	$Marker2D/Fadeout.play("fadeot")


func _on_fadeout_animation_finished(anim_name):
	$Timer.start()
	print("a")
