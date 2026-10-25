extends Node2D

var a = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$star1.play("no")
	$star2.play("no")
	$star3.play("no")
	$bar1/gflower1.play("no")
	$bar2/gflower2.play("no")
	$bar3/gflower3.play("no")
	$gflower4.play("no")
	
	$bar1.position.y = 137 - (float(gl.a1) / gl.a4 * 102)
	$bar2.position.y = 137 - (float(gl.a2) / gl.a4 * 102)
	$bar3.position.y = 137 - (float(gl.a3) / gl.a4 * 102)
	
	
	var tween = get_tree().create_tween()
	tween.parallel().tween_property($bg, "position", Vector2(144.0,81.0), 3).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	await tween.finished
	$complete.visible = true
	
	$levelname.text = gl.lvlname
	
	gl.tpoints = gl.time * 10
	gl.points += gl.tpoints
	
	$c.text = "collectables collected: "+str(gl.cpoints)
	$cbonus.text ="bonus: "+str(gl.bcpoints)
	$e.text = "enemies defeated: "+str(gl.epoints)
	$ebonus.text = "combo bonus: "+str(gl.bepoints)
	$t.text = "time bonus:" + str(gl.tpoints)
	if gl.star1 == true:
		$star1.play("yes")
	else:
		$star1.play("no")
	if gl.star2 == true:
		$star2.play("yes")
	else:
		$star2.play("no")
	if gl.star3 == true:
		$star3.play("yes")
	else:
		$star3.play("no")
	$star.text = "+" + str(gl.spoints)
	
	$total.text = "total score: "+str(gl.points)
	
	$bar1/gpoints1.text = str(gl.a1)
	$bar2/gpoints2.text = str(gl.a2)
	$bar3/gpoints3.text = str(gl.a3)
	$cpoints.text = str(gl.a4)
	
	$progress.max_value = gl.a4
	
	var tween2 = get_tree().create_tween()
	tween2.parallel().tween_property($progress, "value", gl.points, 1).set_trans(Tween.TRANS_SINE)
	var tween4 = get_tree().create_tween()
	print((float(gl.points) / gl.a4 * 102))
	tween4.parallel().tween_property(self, "a", gl.points, 1).set_trans(Tween.TRANS_SINE)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		tracks.get(tracks.current_world).get(tracks.current_point).get("locked").clear()
		gl.pause = false
		get_tree().change_scene_to_file(tracks.current_world_scene)
	$pbar.position.y = 137 -  (float($progress.value) / gl.a4 * 102)
	$pbar/pointsbar.text = str(a)
	if a >= gl.a1:
		$bar1/gflower1.play("yes")
	else:
		$bar1/gflower1.play("no")
	if a >= gl.a2:
		$bar2/gflower2.play("yes")
	else:
		$bar2/gflower2.play("no")
	if a >= gl.a3:
		$bar3/gflower3.play("yes")
	else:
		$bar3/gflower3.play("no")
	if a >= gl.a4:
		$gflower4.play("yes")
	else:
		$gflower4.play("no")
