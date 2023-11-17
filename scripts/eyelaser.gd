extends RayCast2D

var casting = true: set = _set_casting
@onready var timer = $Timer
@export var wait_time:float

var playerhit = false

func _ready():
	timer.wait_time = wait_time
	appear()
	set_physics_process(true)
	$Line2D.points[1] = Vector2.ZERO
	

func _physics_process(delta):
	var cast_point := target_position
	force_raycast_update()
	
	if is_colliding():
		cast_point = to_local(get_collision_point())
		
		var collision = get_collider()
		if collision.name == "Player" && !playerhit:
			collision.get_node("InvFrames").play("Inv")
			var tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE)
			tween.tween_property(collision, "health", collision.health - 50, 0.25)
			collision.can_move = true
			collision.velocity.y -= 10
			State.player.velocity -= (self.global_position-collision.global_position).normalized() * 300
			collision.get_node("HitFlashPlayer").play("HitFlash")
			State.frameFreeze(0.1, 0.05)
			playerhit = true
	
	$Line2D.points[1] = cast_point
	
func _set_casting(cast:bool):
	casting = cast
	set_physics_process(casting)
	

func appear():
	collide_with_bodies = true
	playerhit = false
	var tween = get_tree().create_tween()
	tween.tween_property($Line2D,"width",5.0,0.2)
	
func disapper():
	var tween = get_tree().create_tween()
	tween.tween_property($Line2D,"width",0.0,0.2)
	
	
func _on_timer_timeout():
	collide_with_bodies = false
	disapper()

