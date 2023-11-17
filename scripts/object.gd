extends Node2D

@export var nagme:String
@export var sprite:Texture2D
@export var sprite_scale:Vector2
@export var can_go:String

var draggable = false
var is_inside_dropable = false
var body_ref
var offset: Vector2
var initialPos: Vector2

func _ready():
	$Sprite2D.texture = sprite
	$Sprite2D.scale = sprite_scale

func _process(delta):
	if draggable:
		if Input.is_action_just_pressed("Left_Click"):
			initialPos = global_position
			offset = get_global_mouse_position() - global_position
			GlobalDrag.is_dragging = true
		if Input.is_action_pressed("Left_Click"):
			global_position = get_global_mouse_position() - offset
		elif Input.is_action_just_released("Left_Click"):
			GlobalDrag.is_dragging = false
			var tween = get_tree().create_tween()
			if is_inside_dropable && body_ref.name == can_go or body_ref.is_in_group("empty"):
				tween.tween_property(self,"position",body_ref.position,0.2).set_ease(Tween.EASE_OUT)
			else:
				tween.tween_property(self,"global_position",initialPos,0.2).set_ease(Tween.EASE_OUT)
	if body_ref.is_in_group("weapon") && nagme == "vision":
		State.VisionCompHave = true
		


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
		body.modulate = Color(Color.DARK_GOLDENROD,1)
		body_ref = body
		
func _on_area_2d_body_exited(body):
	if body.is_in_group("dropable"):
		is_inside_dropable = false
		body.modulate = Color(Color.ORANGE, 0.7)
