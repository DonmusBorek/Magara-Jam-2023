extends RayCast2D

var casting = true: set = _set_casting
@onready var timer = $Timer


func _ready():
	appear()
	set_physics_process(true)
	$Line2D.points[1] = Vector2.ZERO
	

func _physics_process(delta):
	var cast_point := target_position
	force_raycast_update()
	
	if is_colliding():
		cast_point = to_local(get_collision_point())
	
	$Line2D.points[1] = cast_point
	
func _set_casting(cast:bool):
	casting = cast
	set_physics_process(casting)
	

func appear():
	var tween = get_tree().create_tween()
	tween.tween_property($Line2D,"width",30.0,0.2)
	
func disapper():
	var tween = get_tree().create_tween()
	tween.tween_property($Line2D,"width",0.0,0.2)
	
	
func _on_timer_timeout():
	disapper()
