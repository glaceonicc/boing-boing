extends Node2D

var current_world = tracks.current_world


func _ready() -> void:
	position.x = tracks.get(current_world).get(tracks.current_point).get("x")
	position.y = tracks.get(current_world).get(tracks.current_point).get("y")

func _process(delta: float) -> void:
	gl.play_y = position.y
	if Input.is_action_just_pressed("up"):
		if not tracks.get(current_world).get(tracks.current_point).get("up") == "no":
			var next_point = tracks.get(current_world).get(tracks.current_point).get("up")
			var pointx = tracks.get(current_world).get(next_point).get("x")
			var pointy = tracks.get(current_world).get(next_point).get("y")
			var tween = get_tree().create_tween()
			tween.parallel().tween_property(self, "position", Vector2(pointx, pointy), 0.3).set_trans(Tween.TRANS_SINE)
			tracks.current_point = next_point
	if Input.is_action_just_pressed("left"):
		if not tracks.get(current_world).get(tracks.current_point).get("left") == "no":
			var next_point = tracks.get(current_world).get(tracks.current_point).get("left")
			var pointx = tracks.get(current_world).get(next_point).get("x")
			var pointy = tracks.get(current_world).get(next_point).get("y")
			var tween = get_tree().create_tween()
			tween.parallel().tween_property(self, "position", Vector2(pointx, pointy), 0.3).set_trans(Tween.TRANS_SINE)
			tracks.current_point = next_point
	if Input.is_action_just_pressed("right"):
		if not tracks.get(current_world).get(tracks.current_point).get("right") == "no":
			var next_point = tracks.get(current_world).get(tracks.current_point).get("right")
			var pointx = tracks.get(current_world).get(next_point).get("x")
			var pointy = tracks.get(current_world).get(next_point).get("y")
			var tween = get_tree().create_tween()
			tween.parallel().tween_property(self, "position", Vector2(pointx, pointy), 0.3).set_trans(Tween.TRANS_SINE)
			tracks.current_point = next_point
	if Input.is_action_just_pressed("down"):
		if not tracks.get(current_world).get(tracks.current_point).get("down") == "no":
			var next_point = tracks.get(current_world).get(tracks.current_point).get("down")
			var pointx = tracks.get(current_world).get(next_point).get("x")
			var pointy = tracks.get(current_world).get(next_point).get("y")
			var tween = get_tree().create_tween()
			tween.parallel().tween_property(self, "position", Vector2(pointx, pointy), 0.3).set_trans(Tween.TRANS_SINE)
			tracks.current_point = next_point
