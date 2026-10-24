extends CharacterBody2D

# omg this is going to be painful

# so i need to code my own gravity is_on_floor and jumping system thing because its gonna be a topdown game
# flowerrrr

var SPEED = 600.0 # the thing to multiply the velocity things by
var MAXSPEED = 125.0
var JUMP_VELOCITY = 4.0 # like how high you jump i guess??

var elevation = 0 # simulates position.y kinda i think. like position.y is now z and this is the y instead.
var vel_y = 0# velocity.y. but like. i made it.
var ground: int # how many ground tiles are you on
var gravity = 10 #heheha i made gravity im newton
var bounce = false # checks if you're in a bouncer
var spike: int # how many spike tiles are you on
var airtime := 0.0

var flicker = true # handles the flickering of blinkblocks
var cycle = 1 # handles spike cycle

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
	gl.lvltime = time
	gl.max_y = max_y
	gl.BPM = BPM
	gl.hearts = 3
	gl.points = 0
	
	gl.connect("kill", die)
	gl.connect("boing", boing)
	
	blockflicker()
	spikecycle()
	
	$sprite.play("sprout")
	$shadow.visible = false
	DisplayServer.window_set_title("PRESS SPACE TO START")
	

func _physics_process(delta: float) -> void:
	if gl.pause == false:
		if active == true:
			if Input.is_action_pressed("left"):
				velocity.x = move_toward(velocity.x, -MAXSPEED, SPEED * delta)
			elif Input.is_action_pressed("right"):
				velocity.x = move_toward(velocity.x, MAXSPEED, SPEED * delta)
			else:
				velocity.x = move_toward(velocity.x, 0, 1.5 * SPEED * delta)
			
			if Input.is_action_pressed("up"):
				velocity.y = move_toward(velocity.y, -MAXSPEED, SPEED * delta)
			elif Input.is_action_pressed("down"):
				velocity.y = move_toward(velocity.y, MAXSPEED, SPEED * delta)
			else:
				velocity.y = move_toward(velocity.y, 0, 1.5 * SPEED * delta)
			
			#ahhhhhhh how to physics
			# so like: elevation is position.y, and if it's = 0 and you're touching floortiles, that means you're on the ground
			# vel_y is kind of like velocity.y, but its not a vector
			# and JUMP_VELOCITY is what you add to velocity to jump
			# and gravity. the thing that pulls you to the ground and makes you not want to get up anymore.
			
			# i searched "how to make gravity" on the internet in order to understand this stuff ;-;
			
			if Input.is_action_just_pressed("jump") and ground >= 1 and elevation == 0 or Input.is_action_just_pressed("jump") and airtime < 0.04 and ground < 1:
				vel_y = JUMP_VELOCITY
			elif elevation <= 0 and elevation > -4 and bounce == true:
				vel_y = 5.0
			elif ground >= 1 and elevation <= 0 and elevation > -3:
				vel_y = 0
				elevation = 0
				airtime = 0.0
			else:
				vel_y -= gravity * delta
				airtime += delta
			
			if elevation == 0 and spike >= 1:
				die()
			
			elevation = floor(elevation + vel_y)
			$sprite.position.y = - elevation
			
			if ground >= 1 and elevation >= 0 or bounce == true and elevation >= 0 or spike >= 1 and elevation >= 0:
				$shadow.visible = true
			else:
				$shadow.visible = false
			
			if elevation >= 0:
				$dot.visible = true
				z_index = 6
			else:
				$dot.visible = false
				z_index = -10
			if elevation <= -500:
				die()
			
			move_and_slide()
		
		else:
			z_index = 6
			$shadow.visible = false
			$dot.visible = false
			if Input.is_action_just_pressed("jump"):
				active = true
				vel_y = JUMP_VELOCITY
				$sprite.play("down")
				$dot.visible = true
				$shadow.visible = true
				DisplayServer.window_set_title(levelname)
				$timer.start()
				move_and_slide()
		gl.play_x = position.x
		gl.play_y = position.y
		gl.play_pos = position
		gl.play_elevation = elevation
		gl.colorflicker = flicker
		gl.spikecycle = cycle
		gl.active = active
		gl.lvlname = levelname #wtf
		#print(str(elevation))
	

# if you're touching at least one ground tile that means you are standing on the ground!
func _on_g_area_entered(area: Area2D) -> void:
	if area.is_in_group("ground"):
		ground += 1
	if area.is_in_group("bouncer"):
		bounce = true
	if area.is_in_group("win"):
		gl.emit_signal("win")


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
	if area.is_in_group("kill"):
		die()


func _on_death_area_exited(area: Area2D) -> void:
	if area.is_in_group("spike"):
		spike -= 1

func die():
	if gl.pause == false:
		if gl.hearts == 1:
			gl.lives -= 1
			get_tree().change_scene_to_file(tracks.current_world_scene)
		else:
			gl.hearts -= 1
			if gl.checkpointnew == false: # respawning without a checkpoint
				position.x = checkpoint_x
				position.y = checkpoint_y
				gl.points = 0
				gl.star1 = false
				gl.star2 = false
				gl.star3 = false
				gl.time = time
			else: # respawning from checkpoint
				position = gl.checkpointxy
				gl.points = gl.Cpoints
				gl.star1 = gl.Cstar1
				gl.star2 = gl.Cstar2
				gl.star3 = gl.Cstar3
				gl.time = time
			move_and_slide()
			gl.emit_signal("die")
			active = false
			elevation = 0
			$sprite.position.y = 0
			$sprite.visible = true
			$sprite.play("sprout")
			vel_y = 0

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
	if cycle < 4:
		cycle += 1
	else:
		cycle = 1

func boing(): #the bounce you get when killing an enemy
	vel_y = 2.5
