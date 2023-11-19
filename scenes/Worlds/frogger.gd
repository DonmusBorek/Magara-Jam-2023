extends CanvasLayer

var koyun = true
var inek = true
# Called when the node enters the svcene tree for the first time.
func _ready():
	$ackapa.bossroom = true
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(!$giris.is_playing() && koyun):
		$giris.visible = false
	else:
		$giris.visible = true
	if($giris.frame == 27):
		koyun = false
		$giris.pause()
		var tween = get_tree().root.create_tween()
		tween.tween_property($giris, "position", Vector2($giris.position.x, -300), 1)
		if(tween.finished && inek):
			$AnimationPlayer.play("sagakayma")
			inek = false
