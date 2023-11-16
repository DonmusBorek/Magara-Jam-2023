extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	modulate = Color(Color.GRAY, 0.7)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GlobalDrag.is_dragging:
		visible = false
	else :
		visible = true
