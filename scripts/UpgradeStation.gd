extends Control
# Called when the node enters the scene tree for the first time.
func _ready():
	fadeout()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func  fadeout():
	$Fadeout.play("fadeot")
