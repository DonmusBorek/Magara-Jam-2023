extends CanvasLayer

signal dead

var a = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $HPBar.value == 0 && a:
		emit_signal("dead")
		a = false
