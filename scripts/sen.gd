extends RigidBody2D
 # sen. the sleeping gem thing with powerful psychic abilities. it could destroy you in an instant if it wasnt sleeping all the time...

var base
var go_vector
var inside = false
var killed = false

@export var range = 2 #measured in tiles, radius of the sen circle
@export var object = "res://elements/spikeball.tscn" #the things that rotate on the circle. putting world0 or something wouldnt be a good idea.
@export var count = 3 #how many object are there
@export var speed = 2.5
@export var direction = 1 #set it to -1 to make it spin the other way
@export var mecha = false

var r = load("res://elements/rotator.tscn")
#@onready var s = $spawn

func _ready() -> void:
	object = load(object)
	$sprite.play("default")
	gl.connect("die", reset)
	base = position
	spawn_children()

func _process(delta: float) -> void:
	if gl.active == true:
		if killed == false:
			
			if inside == true:
				if gl.play_elevation > 5 and gl.play_elevation < 12 and mecha == false:
						if gl.can_jump == true:
							gl.emit_signal("high_boing")
						else:
							gl.emit_signal("boing")
						gl.epoints+= 200
						killed = true
						for i in $spawn.get_children():
							$spawn.remove_child(i)
							i.queue_free()
				elif 0 <= gl.play_elevation and gl.play_elevation < 5:
					gl.emit_signal("kill")
		else:
			visible = false

func reset():
	for i in $spawn.get_children():
		$spawn.remove_child(i)
		i.queue_free()
	go_vector = position
	linear_velocity = Vector2(0, 0)
	position = base
	killed = false
	visible = true
	spawn_children()

func _on_kill_area_entered(area: Area2D) -> void:
	if area.is_in_group("collect"):
		inside = true

func _on_kill_area_exited(area: Area2D) -> void:
	if area.is_in_group("collect"):
		inside = false

func spawn_children():
	var rah = 0.0
	for i in count:
		var ro = r.instantiate()
		rah += 2 * PI / count
		ro.rotation = rah
		ro.speed = speed
		ro.direction = direction
		var obj = object.instantiate()
		obj.position.x += range * 16
		$spawn.add_child(ro)
		ro.add_child(obj)
