extends RigidBody2D
 # yorb... the atrocius... yellow orb... we hate him.... die in a fire, yorb...
var sight = false
var attacksight = false # if player is in range of being attacked
var base
var go_vector
var inside = false
var canshoot = true
var killed = false

var yorbanana = load("res://elements/bullet.tscn") # yorb's stupid projectile

var vel_y = 0
var gravity = 10
var elevation = 0

func _ready() -> void:
	$sprite.play("default")
	gl.connect("die", reset)
	base = position

func _process(delta: float) -> void:
	if gl.active == true:
		if killed == false:
			if sight == true:
				go_vector = gl.play_pos - position
				linear_velocity = - go_vector.normalized() * 1750 * delta
			else:
				linear_velocity = Vector2(0, 0)
			if inside == true:
				if gl.play_elevation > 5 and gl.play_elevation < 12:
					gl.emit_signal("boing")
					gl.points+= 250
					killed = true 
				elif 0 <= gl.play_elevation and gl.play_elevation < 5:
					gl.emit_signal("kill")
			if attacksight == true and canshoot == true:
				canshoot = false
				shoot()
		else:
			visible = false


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


func _on_attacksight_area_entered(area: Area2D) -> void:
	if area.is_in_group("collect"):
		attacksight = true


func _on_attacksight_area_exited(area: Area2D) -> void:
	if area.is_in_group("collect"):
		attacksight = false

func shoot():
	$thethingthatshoots.rotation = get_angle_to(gl.play_pos)
	var bullet = yorbanana.instantiate()
	bullet.rotation = get_angle_to(gl.play_pos)
	add_child(bullet)
	$shootimer.start()


func _on_shootimer_timeout() -> void:
	canshoot = true
