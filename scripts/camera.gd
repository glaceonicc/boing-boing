extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

 # FIX OMG
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if offset.y > gl.play_y + 10:
		offset.y =  move_toward(offset.y, gl.play_y - 10, 110*delta)
		
