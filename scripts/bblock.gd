extends StaticBody2D

func _ready() -> void:
	gl.connect("die", reset)

func _on_break_area_entered(area: Area2D) -> void:
	if area.is_in_group("leaf"):
		$hitbox.set_deferred("disabled", true)
		visible = false

func reset():
		$hitbox.set_deferred("disabled", false)
		visible = true
