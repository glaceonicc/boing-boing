extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gl.connect("die", reset)
	gl.connect("win", win)
 # FIX OMG
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if position.y > gl.play_y + 10 and position.y > gl.max_y:
		position.y =  move_toward(position.y, gl.play_y - 10, 120*delta)
	
	$timer/time.text = str(gl.time)
	$lives/amount.text = "x" + str(gl.lives)
	$points/amount.text = str(gl.points)
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
	hearts()
	$levelinfo/name.text = gl.lvlname

func reset():
	if gl.checkpointnew == true:
		position.y = (gl.checkpointxy.y - 10)
	else: 
		position.y = 0

func hearts():
	var _3 = $"hearts/1"
	var _2 = $"hearts/2"
	var _1 = $"hearts/3"
	
	if gl.hearts == 3:
		_1.play("yes")
	else:
		_1.play("no")
	
	if gl.hearts >= 2:
		_2.play("yes")
	else:
		_2.play("no")
	
	if gl.hearts >= 1:
		_3.play("yes")
	else:
		_3.play("no")

func win():
	var winscene = load("res://winscreen.tscn")
	var wins = winscene.instantiate()
	wins.position = Vector2(-144.0,-81.0)
	add_child(wins)
	gl.pause = true
