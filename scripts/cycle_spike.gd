extends Area2D

@export var c1 = true
@export var c2 = true
@export var c3 = true
@export var c4 = true

var owie: bool

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	if gl.spikecycle == 1:
		if c1 == true:
			owie = true
		else:
			owie = false
	if gl.spikecycle == 2:
		if c2 == true:
			owie = true
		else:
			owie = false
	if gl.spikecycle == 3:
		if c3 == true:
			owie = true
		else:
			owie = false
	if gl.spikecycle == 4:
		if c4 == true:
			owie = true
		else:
			owie = false
	if owie == true:
		$sprite.play("true")
		$hitbox.set_deferred("disabled", false)
	else:
		$sprite.play("false")
		$hitbox.set_deferred("disabled", true)
