extends Node2D

@export var nagme:String
@export var sprite:Texture2D
@export var sprite_scale:Vector2
@export var can_go:String

var draggable = false
var is_inside_dropable = false
var body_ref:StaticBody2D
var offset: Vector2
var initialPos: Vector2
var can_move = true

var has_ref = false

func _ready():
	$Sprite2D.texture = sprite
	$Sprite2D.scale = sprite_scale

func _process(delta):
	if can_move:
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
					
		if has_ref:
			if body_ref.name == "Head" && nagme == "vision" && !draggable:
				State.VisionCompHave = true
				if State.currentWorld == 2:
					can_move = false
				else :
					can_move = true
			elif body_ref.name == "Empty" && nagme == "vision" && draggable:
				State.VisionCompHave = false
			if body_ref.name == "Left_Hand" && nagme == "pump" && !draggable:
				State.EyePump = true
			elif body_ref.name == "Empty" && nagme == "pump" && draggable:
				State.EyePump = false
			if body_ref.name == "Right_Hand" && nagme == "knife" && !draggable:
				State.knife = true
			elif body_ref.name == "Empty" && nagme == "knife" && draggable:
				State.knife = false
			if body_ref.name == "Ability" && nagme == "dash" && !draggable:
				State.Dash = true
			elif body_ref.name == "Empty" && nagme == "dash" && draggable:
				State.Dash = false


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
		has_ref = true
		
func _on_area_2d_body_exited(body):
	if body.is_in_group("dropable"):
		is_inside_dropable = false
		body.modulate = Color(Color.ORANGE, 0.7)
