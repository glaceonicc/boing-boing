extends AnimatedSprite2D

func _ready() -> void:
	var random = randi_range(1, 4096)
	if random == 1:
		play("shiny")
	else:
		play("default")
