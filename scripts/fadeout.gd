extends Marker2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Fadeout1.play_backwards("fadeout")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
