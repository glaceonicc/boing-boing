extends CharacterBody2D

# ong this is going to be painful

# so i need to code my own gravity is_on_floor and jumping system thing because its gonna be a topdown game
# flowerrrr

var SPEED = 800.0 # the thing to multiply the velocity things by
var JUMP_VELOCITY = 4.0 # like how high you jump i guess??
var elevation = 0 # simulates position.y kinda i think. like position.y is now z and this is the y instead.
var vel_y = 0# velocity.y. but like. i made it.
var ground: int # how many ground tiles are you on
var gravity = 10 #heheha i made gravity im newton
var bounce = false # checks if you're in a bouncer
var spike: int # how many spike tiles are you on
var flicker = true
var cycle = 1

var checkpoint_x
var checkpoint_y

var active = false # if you started playing (press space to start)

@export var startpos_x = 0
@export var startpos_y = 64
@export var max_y = -10000
@export var time = 500
@export var BPM = 200

@export var levelname: String

func _ready() -> void:
	position.x = startpos_x
	position.y = startpos_y
	checkpoint_x = startpos_x
	checkpoint_y = startpos_y
	gl.checkpointnew = false
	gl.time = time
	gl.max_y = max_y
	gl.BPM = BPM
	
	gl.connect("kill", die)
	gl.connect("boing", boing)
	
	blockflicker()
	spikecycle()
	
	$sprite.play("sprout")
	DisplayServer.window_set_title("PRESS SPACE TO START")
	

func _physics_process(delta: float) -> void:
	if active == true:
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
		
		# i searched "how to make gravity" on the internet in order to understand this stuff ;-;
		
		if ground >= 1 and elevation == 0:
			if Input.is_action_just_pressed("jump"):
				vel_y = JUMP_VELOCITY
			elif elevation == 0.0 and bounce == true:
				vel_y = 5.0
			else:
				vel_y = 0
				elevation = 0
		elif ground >= 1 and elevation <= 0 and elevation > -4:
			vel_y = 0
			elevation = 0
		elif elevation == 0.0 and bounce == true:
			vel_y = 5.0
		else:
			vel_y -= gravity * delta
		
		if elevation == 0 and spike >= 1:
			die()
		
		elevation = floor(elevation + vel_y)
		$sprite.position.y = - elevation
		if elevation <= -500:
			die()
			elevation = 0
			vel_y = 0
			
		

			
		move_and_slide()
		if ground > 0 or bounce == true or spike > 0 and elevation > 0:
			$shadow.visible = true
		else:
			$shadow.visible = false
	else:
		if Input.is_action_just_pressed("jump"):
			active = true
			vel_y = JUMP_VELOCITY
			$sprite.play("down")
			$dot.visible = true
			$shadow.visible = true
			DisplayServer.window_set_title(levelname)
			$timer.start()
	gl.play_x = position.x
	gl.play_y = position.y
	gl.play_pos = position
	gl.play_elevation = elevation
	gl.colorflicker = flicker
	gl.spikecycle = cycle
	print(str(elevation))

# if you're touching at least one ground tile that means you are standing on the ground!
func _on_g_area_entered(area: Area2D) -> void:
	if area.is_in_group("ground"):
		ground += 1
	if area.is_in_group("bouncer"):
		bounce = true


func _on_g_area_exited(area: Area2D) -> void:
	if area.is_in_group("ground"):
		ground -= 1
	if area.is_in_group("bouncer"):
		bounce = false


func _on_timer_timeout() -> void:
	gl.time -= 1


func _on_death_area_entered(area: Area2D) -> void:
	if area.is_in_group("spike"):
		spike += 1


func _on_death_area_exited(area: Area2D) -> void:
	if area.is_in_group("spike"):
		spike -= 1

func die():
	gl.hearts -= 1
	if gl.checkpointnew == false:
		position.x = checkpoint_x
		position.y = checkpoint_y
	else:
		position = gl.checkpointxy
	gl.emit_signal("die")

func blockflicker():
	var t = float(BPM) / 4
	t = 60 / float(t)
	$flickertimer.wait_time = t
	$flickertimer.start()

func spikecycle():
	var s = float(BPM) / 5
	s = 30 / float(s)
	$spiketimer.wait_time = s
	$spiketimer.start()

func _on_flickertimer_timeout() -> void:
	if flicker == true:
		flicker = false
	else:
		flicker = true

func _on_spiketimer_timeout() -> void:
	if cycle < 5:
		cycle += 1
	else:
		cycle = 1

func boing(): #the bounce you get when killing an enemy
	vel_y = 2.5
