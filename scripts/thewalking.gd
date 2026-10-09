extends RigidBody2D
 # THE WALKING ( IT WALKS) BIG PAW CREATURE!!!!!!!!!!!!!!!!!!!!
var sight = false
var base
var go_vector
var ground = 0
var reseting = false
var inside = false
var toreset = false # makes it not deal damage twice

var vel_y = 0
var gravity = 10
var elevation = 0

func _ready() -> void:
	$sprite.play("default")
	gl.connect("die", reset)
	base = position

func _process(delta: float) -> void:
	if sight == true and ground >= 1 and gl.active == true:
		# thank you godot forum for this solution
		go_vector = gl.play_pos - position
		linear_velocity = go_vector.normalized() * 1000 * delta
		# my previous script that went through walls for some reason
	elif ground >= 1:
		# i still dont know how to set it to zero in one line of code ;-;
		linear_velocity.x = move_toward(linear_velocity.x, 0, 1)
		linear_velocity.y = move_toward(linear_velocity.y, 0, 1)
	else:
		vel_y -= gravity * delta
		
	if inside == true:
		if gl.play_elevation > 5 and gl.play_elevation < 12:
			gl.emit_signal("boing")
			gl.points+= 100
			queue_free()
		elif 0 <= gl.play_elevation < 5 and toreset == false:
			gl.emit_signal("kill")
			toreset = true
			
	elevation = floor(elevation + vel_y)
	$sprite.position.y = - elevation
	if elevation < -500:
		gl.points +=100
		queue_free()


func _on_sight_area_entered(area: Area2D) -> void:
	if area.is_in_group("collect"):
		sight = true

func _on_sight_area_exited(area: Area2D) -> void:
	if area.is_in_group("collect"):
		sight = false

func reset():
	reseting = true
	go_vector = position
	linear_velocity.x = 0
	linear_velocity.y = 0
	position = base
	reseting = false
	toreset = false

func _on_kill_area_entered(area: Area2D) -> void:
	if area.is_in_group("ground"):
		ground += 1
	if area.is_in_group("collect"):
		inside = true

func _on_kill_area_exited(area: Area2D) -> void:
	if area.is_in_group("ground"):
		ground -= 1
	if area.is_in_group("collect"):
		inside = false
