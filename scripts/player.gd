extends CharacterBody2D

# ong this is going to be painful

# so i need to code my own gravity is_on_floor and jumping system thing because its gonna be a topdown game
# flowerrrr

var SPEED = 400.0
var JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	if velocity.x >= -200 and velocity.x <= 200:
		if Input.is_action_pressed("left"):
			velocity.x -= SPEED * delta
		elif Input.is_action_pressed("right"):
			velocity.x += SPEED * delta
		else:
			velocity.x = move_toward(velocity.x, 0, 500 * delta)
	
	if velocity.y >= -200 and velocity.y <= 200:
		if Input.is_action_pressed("up"):
			velocity.y -= SPEED * delta
			
		elif Input.is_action_pressed("down"):
			velocity.y += SPEED * delta
		else:
			velocity.y = move_toward(velocity.y, 0, 500 * delta)
			
			# might need this when implementing my own jump system thing later
	#if not is_on_floor():
		#velocity += get_gravity() * delta
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
	
	#velocity.x = move_toward(velocity.x, 0, SPEED)
	#velocity.y = move_toward(velocity.y, 0, SPEED)
	move_and_slide()
