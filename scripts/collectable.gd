extends Area2D

@export var type: int
var inside = false
var collected = false

func _ready() -> void:
	gl.connect("die", reset)

func _process(delta: float) -> void:
	if gl.play_elevation < 15 and inside == true and gl.play_elevation >= 0 and collected == false:
		if type == 1:
			gl.cpoints += 100
		if type == 2:
			if gl.hearts < 3:
				gl.hearts += 1
				gl.cpoints += 100
			else:
				gl.cpoints += 100
				gl.bcpoints += 1000
		if type == 3:
			gl.lives += 1
			gl.cpoints += 1000
		if type == 4:
			gl.star1 = true
			gl.spoints += 1000
		if type == 5:
			gl.star2 = true
			gl.spoints += 1000
		if type == 6:
			gl.star3 = true
			gl.spoints += 1000
		if type == 7:
			gl.time += 10
		collected = true
		if not type == 3:
			gl.begone.append(name)
		else:
			gl.Cbegone.append(name)
	elif collected == true:
		visible = false


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("collect"):
		inside = true


func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("collect"):
		inside = false

func reset():
	inside = false
	if collected == true:
		if name not in gl.Cbegone:
			collected = false
			visible = true
