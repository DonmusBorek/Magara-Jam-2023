extends Node2D

var draggable = false
var is_inside_dropable = false
var body_ref

func _process(delta):
	pass
	


func _on_area_2d_mouse_entered():
	if not GlobalDrag.is_dragging:
		draggable = true
		scale = Vector2(1.05,1.05)


func _on_area_2d_mouse_exited():
	if not GlobalDrag.is_dragging:
		draggable = false
		scale = Vector2(1,1)


func _on_area_2d_body_entered(body:StaticBody2D):
	if body.is_in_group("dropable"):
		is_inside_dropable = true
		body.modulate = Color(Color.DIM_GRAY,1)
		body_ref = body
		
func _on_area_2d_body_exited(body):
	if body.is_in_group("dropable"):
		is_inside_dropable = false
		modulate = Color(Color.GRAY, 0.7)
