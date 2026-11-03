extends RigidBody2D
 # xog. evil! shoots wide log lasers.

var base
var go_vector
var inside = false
var killed = false

@export var mecha = false

var l = load("res://elements/log.tscn")
#@onready var s = $spawn

func _ready() -> void:
	$sprite.play("closed")
	gl.connect("die", reset)
	base = position
	
	var t 
	t = gl.BPM / 4.0
	t = 60.0 / t
	
	shoot()
	
	$Timer.wait_time = t
	$Timer.start()

func _process(delta: float) -> void:
	if gl.active == true:
		if killed == false:
			
			if inside == true:
				if gl.play_elevation > 5 and gl.play_elevation < 12 and mecha == false:
						if gl.can_jump == true:
							gl.emit_signal("high_boing")
						else:
							gl.emit_signal("boing")
						gl.epoints+= 200
						killed = true
				elif 0 <= gl.play_elevation and gl.play_elevation < 5:
					gl.emit_signal("kill")
		else:
			visible = false
			

func reset():
	go_vector = position
	linear_velocity = Vector2(0, 0)
	position = base
	killed = false
	visible = true

func _on_kill_area_entered(area: Area2D) -> void:
	if area.is_in_group("collect"):
		inside = true

func _on_kill_area_exited(area: Area2D) -> void:
	if area.is_in_group("collect"):
		inside = false

func shoot():
	if killed == false and gl.active == true:
		var log = l.instantiate()
		log.rotation = PI/2
		add_child(log)

func _on_timer_timeout() -> void:
	shoot()
	$Timer.start()
