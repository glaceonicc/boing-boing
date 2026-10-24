extends Node2D

var current_world = tracks.current_world
var next_point
var pointx
var pointy
var moved = true

func _ready() -> void:
	position.x = tracks.get(current_world).get(tracks.current_point).get("x")
	position.y = tracks.get(current_world).get(tracks.current_point).get("y")

func _process(delta: float) -> void:
	gl.play_y = position.y
	inputs()

func inputs():
	if moved == true:
		if Input.is_action_just_pressed("up"):
			if not tracks.get(current_world).get(tracks.current_point).get("up") == "no" and tracks.get(current_world).get(tracks.current_point).get("locked").has("up") == false:
				next_point = tracks.get(current_world).get(tracks.current_point).get("up")
				trackgo()
		if Input.is_action_just_pressed("left"):
			if not tracks.get(current_world).get(tracks.current_point).get("left") == "no" and tracks.get(current_world).get(tracks.current_point).get("locked").has("left") == false:
				next_point = tracks.get(current_world).get(tracks.current_point).get("left")
				trackgo()
		if Input.is_action_just_pressed("right"):
			if not tracks.get(current_world).get(tracks.current_point).get("right") == "no" and tracks.get(current_world).get(tracks.current_point).get("locked").has("right") == false:
				next_point = tracks.get(current_world).get(tracks.current_point).get("right")
				trackgo()
		if Input.is_action_just_pressed("down"):
			if not tracks.get(current_world).get(tracks.current_point).get("down") == "no" and tracks.get(current_world).get(tracks.current_point).get("locked").has("down") == false:
				next_point = tracks.get(current_world).get(tracks.current_point).get("down")
				trackgo()
		if Input.is_action_just_pressed("jump"):
			if tracks.get(current_world).get(tracks.current_point).get("thing") == "level":
				get_tree().change_scene_to_file(tracks.get(current_world).get(tracks.current_point).get("stuff"))

func trackgo():
	moved = false
	pointx = tracks.get(current_world).get(next_point).get("x")
	pointy = tracks.get(current_world).get(next_point).get("y")
	
	# learned about "abs"
	var xtime = abs(tracks.get(current_world).get(next_point).get("x")-tracks.get(current_world).get(tracks.current_point).get("x"))
	var ytime = abs(tracks.get(current_world).get(next_point).get("y")-tracks.get(current_world).get(tracks.current_point).get("y"))
	
	var tween = get_tree().create_tween()
	tween.parallel().tween_property(self, "position", Vector2(pointx, pointy), 0.0075 * (xtime + ytime)).set_trans(Tween.TRANS_SINE)
	tracks.current_point = next_point
	await tween.finished
	moved = true
	
