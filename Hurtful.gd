extends Area2D

var attack
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if(body == State.player):
		body.get_node("InvFrames").play("Inv")
		body.health -= attack
		body.can_move = true
		body.velocity.y -= 10
		State.player.velocity -= (self.global_position-body.global_position).normalized() * 250
		body.get_node("HitFlashPlayer").play("HitFlash")
		State.frameFreeze(0.1, 0.05)
	pass # Replace with function body.
