extends Node

var active = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(!active):
		get_parent().set_process(false)
		get_parent().set_physics_process(false)
		get_parent().visible = false
	else:
		get_parent().set_process(true)
		get_parent().set_physics_process(true)
		get_parent().visible = true
	pass
