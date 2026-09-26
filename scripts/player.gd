extends CharacterBody2D

# ong this is going to be painful

# so i need to code my own gravity is_on_floor and jumping system thing because its gonna be a topdown game
# flowerrrr

var SPEED = 800.0 # the thing to multiply the velocity things by
var JUMP_VELOCITY = 4.0 # like how high you jump i guess??
var elevation = 0 # simulates position.y kinda i think. like position.y is now z and this is the y instead.
var vel_y = 0# velocity.y. but like. i made it.
var ground: int
var gravity = 10 #heheha i made gravity im newton

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("left"):
		velocity.x = move_toward(velocity.x, -150, SPEED * delta)
	elif Input.is_action_pressed("right"):
		velocity.x = move_toward(velocity.x, 150, SPEED * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, 1.5 * SPEED * delta)
	
	if Input.is_action_pressed("up"):
		velocity.y = move_toward(velocity.y, -150, SPEED * delta)
	elif Input.is_action_pressed("down"):
		velocity.y = move_toward(velocity.y, 150, SPEED * delta)
	else:
		velocity.y = move_toward(velocity.y, 0, 1.5 * SPEED * delta)
	
	#ahhhhhhh how to physics
	# so like: elevation is position.y, and if it's = 0 and you're touching floortiles, that means you're on the ground
	# vel_y is kind of like velocity.y, but its not a vector
	# and JUMP_VELOCITY is what you add to velocity to jump
	# and gravity. the thing that pulls you to the ground and makes you not want to get up anymore.
	
	# i searched "how to make gravity" on the internet in order to understand this stuff
	
	if ground >= 1 and elevation == 0:
		if Input.is_action_just_pressed("jump"):
			vel_y = JUMP_VELOCITY
		else:
			vel_y = 0
	else:
		vel_y -= gravity * delta
	elevation = floor(elevation + vel_y)
	$sprite.position.y = - elevation
	print(ground)
	if elevation <= -500:
		elevation = 0
		vel_y = 0
		
	move_and_slide()
	if ground == 0:
		$shadow.visible = false
	else:
		$shadow.visible = true
	gl.play_y = position.y

# if you're touching at least one ground tile that means you are standing on the ground!
func _on_g_area_entered(area: Area2D) -> void:
	if area.is_in_group("ground"):
		ground += 1


func _on_g_area_exited(area: Area2D) -> void:
	if area.is_in_group("ground"):
		ground -= 1
