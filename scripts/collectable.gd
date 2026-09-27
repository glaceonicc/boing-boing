extends Area2D

@export var type: int

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("collect"):
		if type == 1:
			gl.points += 100
		if type == 2:
			if gl.hearts < 3:
				gl.hearts += 1
				gl.points += 100
			else:
				gl.points += 1000
		if type == 3:
			gl.lives += 1
			gl.points += 1000
		if type == 4:
			gl.star1 = true
			gl.points += 1000
		if type == 5:
			gl.star2 = true
			gl.points += 1000
		if type == 6:
			gl.star3 = true
			gl.points += 1000
		queue_free()
