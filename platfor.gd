extends AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_platformdetect_body_entered(body):
	if(body == State.player):
		speed_scale = 1
		play("platfor")
	pass # Replace with function body.


func _on_platformdetect_body_exited(body):
	if(body == State.player):
		speed_scale = 3
		play_backwards("platfor")
	pass # Replace with function body.
