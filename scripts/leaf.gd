extends RigidBody2D
 # leaf : spikey!
var sight = false
var base
var go_vector
var ground = 0
var reseting = false
var toreset = false # makes it not deal damage twice

var vel_y = 0
var gravity = 10
var elevation = 0

func _ready() -> void:
	$sprite.play("default")
	gl.connect("die", reset)
	base = position
	add_to_group("spike")

func _process(delta: float) -> void:
	if sight == true and ground >= 1 and gl.active == true:
		go_vector = gl.play_pos - position
		linear_velocity = go_vector.normalized() * 3000 * delta
	elif ground >= 1:
		linear_velocity.x = move_toward(linear_velocity.x, 0, 1)
		linear_velocity.y = move_toward(linear_velocity.y, 0, 1)
	else:
		vel_y -= gravity * delta

	elevation = floor(elevation + vel_y)
	$sprite.position.y = - elevation
	if elevation < -500:
		gl.points +=100
		queue_free()
	if elevation < 0:
		$kill/hitbox.set_deferred("disabled", true)
		remove_from_group("spike")

func _on_sight_area_entered(area: Area2D) -> void:
	if area.is_in_group("collect") and elevation <= 0 :
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

func _on_kill_area_exited(area: Area2D) -> void:
	if area.is_in_group("ground"):
		ground -= 1
