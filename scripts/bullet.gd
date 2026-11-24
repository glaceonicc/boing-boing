extends Area2D

func _ready() -> void:
	gl.connect("die", queue_free)

func _process(delta: float) -> void:
	position.x = position.x + 100 * delta

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("collect") and gl.play_elevation == 0:
		queue_free()
	if area.is_in_group("wall"):
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("wall"):
		queue_free()
