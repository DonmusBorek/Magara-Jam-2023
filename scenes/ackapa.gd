extends Marker2D

var changable = false
var deadAnimPlayOnce = true
# Called when the node enters the scene tree for the first time.
func _ready():
	$Fadeout1.play_backwards("fadeout")
	changable = false
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(State.worldEnd):
		$Fadeout1.play("fadeout")
		State.worldEnd = false
		changable = true
	if(State.playerDead && deadAnimPlayOnce):
		deadAnimPlayOnce = false
		$Fadeout1.play("fadeout")
	pass


func _on_fadeout_1_animation_finished(anim_name):
	if(changable):
		get_tree().change_scene_to_file(State.Worlds[State.currentWorld + 1])
		State.currentWorld += 1
		changable = false
	if(State.playerDead):
		get_tree().change_scene_to_file(State.Worlds[State.currentWorld])
		State.playerDead = false
		deadAnimPlayOnce = true
	pass # Replace with function body.
