extends Marker2D

var changable = false
var deadAnimPlayOnce = true
var bossroom = false
# Called when the node enters the scene tree for the first time.
func _ready():
	if State.player != null:
		State.player.can_move = false
		$Fadeout1.play_backwards("fadeout")
		changable = false
	else:
		$Fadeout1.play_backwards("fadeout")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(State.worldEnd):
		$Fadeout1.play("fadeout")
		State.player.can_move = false
		State.worldEnd = false
		changable = true
	if(State.playerDead && deadAnimPlayOnce):
		deadAnimPlayOnce = false
		$Fadeout1.play("fadeout")
	pass


func _on_fadeout_1_animation_finished(anim_name):
	if(changable):
		get_tree().change_scene_to_file(State.Worlds[State.currentWorld + 1])
		#State.currentWorld += 1
		changable = false
	if(State.playerDead):
		get_tree().reload_current_scene()
		State.playerDead = false
		deadAnimPlayOnce = true
	elif(bossroom):
		get_parent().get_node("giris").play("default")
	if State.player != null:
		State.player.can_move = true
