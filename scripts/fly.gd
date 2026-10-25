extends RigidBody2D
 # fly, the annoying thing (kill it) (it flies) (wow)
var sight = false
var base
var go_vector
var inside = false
var killed = false

func _ready() -> void:
	$sprite.play("idle")
	gl.connect("die", reset)
	base = position

func _process(delta: float) -> void:
	if gl.active == true:
		
		if killed == false:
			if sight == true:
				# thank you godot forum for this solution
				go_vector = gl.play_pos - position
				linear_velocity = go_vector.normalized() * 1500 * delta
				# my previous script that went through walls for some reason
			else:
				linear_velocity = Vector2(0, 0)
			if inside == true:
				if gl.play_elevation > 5 and gl.play_elevation < 12:
					gl.emit_signal("boing")
					gl.epoints+= 150
					killed = true
				elif 0 <= gl.play_elevation and gl.play_elevation < 5:
					gl.emit_signal("kill")
					inside = false
		else:
			visible = false
		if sight == true:
			$sprite.play("flying")
		else:
			$sprite.play("idle")


func _on_sight_area_entered(area: Area2D) -> void:
	if area.is_in_group("collect"):
		sight = true

func _on_sight_area_exited(area: Area2D) -> void:
	if area.is_in_group("collect"):
		sight = false

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
