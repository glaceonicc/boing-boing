extends RigidBody2D
 # enemy

var sight = false
var base
var go_vector
var ground = 0
var inside = false
var killed = false
var move = false

var vel_y = 0
var gravity = 10
var elevation = 0

@export var speed: int
@export var points: int

@export var flying: bool
@export var movement: String # chase, avoid, none
@export var bullet: String # yorb, sen, xog, xos, xor
@export var mecha: bool


func _ready() -> void:
	$sprite.play("idle")
	gl.connect("die", reset)
	base = position

func _process(delta: float) -> void:
	if gl.active == true:
		if killed == false:
			if sight == true:
				if flying == false and ground >= 1:
					move = true
				elif flying == true:
					move = true
				else:
					move = false
				
			if inside == true:
				if mecha == false:
					if gl.play_elevation > 5 and gl.play_elevation < 12:
						if gl.can_jump == true:
							gl.emit_signal("high_boing")
						else:
							gl.emit_signal("boing")
						gl.epoints+= points
						killed = true
					elif 0 <= gl.play_elevation and gl.play_elevation < 5:
						gl.emit_signal("kill")
						inside = false
			
			if flying == false and ground < 1:
				vel_y -= gravity * delta
			
			if move == true:
				if movement == "chase":
					go_vector = gl.play_pos - position
					linear_velocity = go_vector.normalized() * speed * delta
				if movement == "avoid":
					go_vector = gl.play_pos - position
					linear_velocity = - go_vector.normalized() * speed * delta
			else:
				linear_velocity = Vector2(0, 0)
			
			
			elevation = floor(elevation + vel_y)
			if elevation < -500:
				gl.points += points
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
