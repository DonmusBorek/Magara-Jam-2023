extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready():
	State.camera = self
	State.cam_offset = offset


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	offset = State.cam_offset
