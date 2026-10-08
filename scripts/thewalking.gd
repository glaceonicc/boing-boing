extends RigidBody2D
 # THE WALKING ( IT WALKS) BIG PAW CREATURE!!!!!!!!!!!!!!!!!!!!
var sight = false
var base
var go_vector
var ground = 0
var reseting = false
var inside = false

func _ready() -> void:
	$sprite.play("default")
	gl.connect("die", reset)
	base = position

func _process(delta: float) -> void:
	if sight == true and ground >= 1:
		# thank you godot forum for this solution
		go_vector = gl.play_pos - position
		linear_velocity = go_vector.normalized() * 2000 * delta
		# my previous script that went through walls for some reason
		#position = position.move_toward(Vector2(gl.play_pos), delta * 40)
	elif ground >= 1:
		# i still dont know how to set it to zero in one line of code ;-;
		linear_velocity.x = move_toward(linear_velocity.x, 0, 1)
		linear_velocity.y = move_toward(linear_velocity.y, 0, 1)
	else:
		linear_velocity.x = move_toward(linear_velocity.x, 0, 60)
		linear_velocity.y = move_toward(linear_velocity.y, 0, 60)
	if inside == true:
		if gl.play_elevation > 5 and gl.play_elevation < 12:
			gl.emit_signal("boing")
			queue_free()
		elif gl.play_elevation < 5:
			gl.emit_signal("kill")

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
