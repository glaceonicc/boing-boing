extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

 # FIX OMG
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if position.y > gl.play_y + 10:
		position.y =  move_toward(position.y, gl.play_y - 10, 110*delta)
	$timer/time.text = str(gl.time)
	$lives/amount.text = "x" + str(gl.lives)
	if gl.star1 == true:
		$"stars/1".play("yes")
	else:
		$"stars/1".play("no")
	if gl.star2 == true:
		$"stars/2".play("yes")
	else:
		$"stars/2".play("no")
	if gl.star3 == true:
		$"stars/3".play("yes")
	else:
		$"stars/3".play("no")
