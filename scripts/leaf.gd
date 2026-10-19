extends RigidBody2D
 # leaf : spikey!
var sight = false
var base
var go_vector
var ground = 0
var reseting = false
var toreset = false # makes it not deal damage twice
var killed = false

var vel_y = 0
var gravity = 10
var elevation = 0

func _ready() -> void:
	$sprite.play("default")
	gl.connect("die", reset)
	base = position
	add_to_group("spike")

func _process(delta: float) -> void:
	if gl.active == true:
		
		if killed == false:
			if ground >= 1:
				if sight == true:
					go_vector = gl.play_pos - position
					linear_velocity = go_vector.normalized() * 3000 * delta
				else:
					linear_velocity = Vector2(0, 0)
			else:
				vel_y -= gravity * delta
			if elevation < -500:
				gl.points +=100
				killed = true
			if elevation < 0:
				$kill/hitbox.set_deferred("disabled", true)
				remove_from_group("spike")
			
			elevation = floor(elevation + vel_y)
		else:
			$kill/hitbox.set_deferred("disabled", true)
			remove_from_group("spike")
			visible = false
		
	$sprite.position.y = - elevation

func _on_sight_area_entered(area: Area2D) -> void:
	if area.is_in_group("collect") and elevation <= 0 :
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
	$kill/hitbox.set_deferred("disabled", false)
	add_to_group("spike")

func _on_kill_area_entered(area: Area2D) -> void:
	if area.is_in_group("ground"):
		ground += 1

func _on_kill_area_exited(area: Area2D) -> void:
	if area.is_in_group("ground"):
		ground -= 1
