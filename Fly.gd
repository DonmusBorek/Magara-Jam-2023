extends CharacterBody2D
var lampDetected
var belovedLamp
func _ready():
	var tween = get_tree().root.create_tween()
	tween.tween_property(self, "velocity", Vector2(randf_range(-30, 30), randf_range(-30, 30)), 5)
	
func _physics_process(delta):
	if(lampDetected):
		if(belovedLamp.enabled):
			var tween = get_tree().root.create_tween()
			tween.tween_property(self, "velocity", (belovedLamp.position - self.position).normalized() * 100, 5)
	move_and_slide()

func _on_timer_timeout():
	if(!lampDetected):
		var tween = get_tree().root.create_tween()
		tween.tween_property(self, "velocity", Vector2(randf_range(-30, 30), randf_range(-30, 30)), 5)
	pass # Replace with function body.


func _on_lamp_detector_body_entered(body):
	if(body.is_in_group("floresan")):
		var tween = get_tree().root.create_tween()
		tween.tween_property(self, "velocity", (body.position - self.position).normalized() * 100, 5)
		belovedLamp = body
		lampDetected = true
	pass # Replace with function body.


func _on_lamp_detector_body_exited(body):
	if(body.is_in_group("floresan")):
		lampDetected = false
	pass # Replace with function body.
