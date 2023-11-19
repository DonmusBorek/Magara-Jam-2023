extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_entered(area):
	if area.is_in_group("soksokattack"):
		$AnimatedSprite2D.animation = "pop"
		State.frameFreeze(0.1, 0.05)
		$AnimatedSprite2D.material.set_shader_parameter("enabled", 1)
		await get_tree().create_timer(0.1).timeout
		$AnimatedSprite2D.material.set_shader_parameter("enabled", 0)
		set_deferred("monitoring",false)
