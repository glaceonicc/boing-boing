extends RigidBody2D
 # THE WALKING ( IT WALKS) BIG PAW CREATURE!!!!!!!!!!!!!!!!!!!!
var sight = false
var base
var go_vector
var ground = 0
var inside = false
var killed = false

var vel_y = 0
var gravity = 10
var elevation = 0

func _ready() -> void:
	$sprite.play("idle")
	gl.connect("die", reset)
	base = position

func _process(delta: float) -> void:
	if gl.active == true:
		
		if killed == false:
			
			if ground >= 1:
				if sight == true:
					# thank you godot forum for this solution
					go_vector = gl.play_pos - position
					linear_velocity = go_vector.normalized() * 1000 * delta
					# my previous script that went through walls for some reason
				else:
					linear_velocity = Vector2(0, 0)
				if inside == true:
					if gl.play_elevation > 5 and gl.play_elevation < 12:
						gl.emit_signal("boing")
						gl.epoints+= 100
						killed = true
					elif 0 <= gl.play_elevation and gl.play_elevation < 5:
						gl.emit_signal("kill")
						inside = false
			else:
				vel_y -= gravity * delta
			
			
			elevation = floor(elevation + vel_y)
			if elevation < -500:
				gl.points +=100
				killed = true
		else:
			visible = false
			vel_y = 0
			elevation = 0
		$sprite.position.y = - elevation
		if sight == true:
			$sprite.play("walking")
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
	vel_y = 0
	elevation = 0
	killed = false
	visible = true

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
