extends Area2D

@export var color = true
# true = red false = blue

func _process(delta: float) -> void:
	if color == true:
		if gl.colorflicker == true:
			$sprite.play("redtrue")
			$hitbox.set_deferred("disabled", false)
		else:
			$sprite.play("redfalse")
			$hitbox.set_deferred("disabled", true)
	else:
		if gl.colorflicker == true:
			$sprite.play("bluefalse")
			$hitbox.set_deferred("disabled", true)
		else:
			$sprite.play("bluetrue")
			$hitbox.set_deferred("disabled", false)
