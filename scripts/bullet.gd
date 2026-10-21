extends Area2D

func _ready() -> void:
	gl.connect("die", queue_free)

func _process(delta: float) -> void:
	var move_vector = Vector2(90, 0).rotated(rotation)
	global_position += move_vector * delta


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("collect") and gl.play_elevation == 0:
		queue_free()
