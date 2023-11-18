extends RayCast2D

var casting = true: set = _set_casting
@onready var timer = $Timer
@export var wait_time:float
@export var width:int

var playerhit = false


func _ready():
	timer.wait_time = wait_time
	timer.start()
	set_physics_process(true)
	$Line2D.points[1] = Vector2.ZERO
	

func _physics_process(delta):
	var cast_point := target_position
	force_raycast_update()
	
	$GPUParticles2D2.emitting = is_colliding()
	
	if is_colliding():
		cast_point = to_local(get_collision_point())
		
		$GPUParticles2D2.global_rotation = get_collision_normal().angle()
		$GPUParticles2D2.position = cast_point
		
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
	
	$GPUParticles2D3.position = cast_point * 0.5
	$GPUParticles2D3.process_material.emission_box_extents.x = cast_point.length() * 0.5
	
func _set_casting(cast:bool):
	casting = cast
	set_physics_process(casting)
	

func appear():
	var tween = get_tree().create_tween()
	$GPUParticles2D3.emitting = true
	collide_with_bodies = true
	$GPUParticles2D.emitting = true
	playerhit = false
	tween.connect("finished", tween_finished2)
	tween.tween_property($Line2D,"width",width,0.2)
	
func disapper():
	var tween = get_tree().create_tween()
	tween.connect("finished", tween_finished)
	tween.tween_property($Line2D,"width",0.0,0.2)
	
	
func _on_timer_timeout():
	appear()
	
func tween_finished():
	collide_with_bodies = false
	$GPUParticles2D3.emitting = false
	$GPUParticles2D2.emitting = false
	$GPUParticles2D.emitting = false
	playerhit = false
	timer.start(1.5)
	
func tween_finished2():
	await get_tree().create_timer(1.5).timeout
	disapper()
