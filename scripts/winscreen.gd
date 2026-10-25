extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween = get_tree().create_tween()
	tween.parallel().tween_property($bg, "position", Vector2(144.0,81.0), 3).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	await tween.finished
	$complete.visible = true
	
	$levelname.text = gl.lvlname
	
	$c.text = "collectables collected: "+str(gl.cpoints)
	$cbonus.text ="bonus: "+str(gl.bcpoints)
	$e.text = "enemies defeated: "+str(gl.epoints)
	$ebonus.text = "combo bonus: "+str(gl.bepoints)
	$t.text = "time bonus:"
	
	$total.text = "total score: "+gl.points
	
	$gpoints1.text = str(gl.a1)
	$gpoints2.text = str(gl.a2)
	$gpoints3.text = str(gl.a3)
	$cpoints.text = str(gl.a4)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		tracks.get(tracks.current_world).get(tracks.current_point).get("locked").clear()
		gl.pause = false
		get_tree().change_scene_to_file(tracks.current_world_scene)
