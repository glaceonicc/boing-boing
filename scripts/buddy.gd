extends RigidBody2D
 # friend!
var base
var go_vector
var inside = false

func _ready() -> void:
	$sprite.play("idle")
	gl.connect("die", reset)
	base = position

func _process(delta: float) -> void:
	if gl.active == true:
		go_vector = gl.play_pos - position
		linear_velocity = go_vector.normalized() * 5000 * delta
	else:
		linear_velocity = Vector2(0, 0)

func reset():
	go_vector = position
	linear_velocity = Vector2(0, 0)
	position = base
	visible = true

func _on_kill_area_entered(area: Area2D) -> void:
	if area.is_in_group("collect"):
		inside = true

func _on_kill_area_exited(area: Area2D) -> void:
	if area.is_in_group("collect"):
		inside = false
