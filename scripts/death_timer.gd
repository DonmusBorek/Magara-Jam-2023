extends Control

signal Deadtime

@onready var timer = $Timer
@onready var seconds = $Seconds
@onready var m_seconds = $MSeconds


# Called when the node enters the scene tree for the first time.
func _ready():
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var msec = fmod(timer.time_left,1) * 100
	seconds.text = "%02d:" % timer.time_left
	m_seconds.text = "%02d" % msec
	


func _on_timer_timeout():
	emit_signal("Deadtime")
