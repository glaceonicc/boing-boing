extends Camera2D

func _ready() -> void:
	pass
func _process(delta: float) -> void:
	position.y = gl.play_y
	$worldname.text = tracks.current_world_name
	$"star count".text = str(gl.stars)
	$"goldf count".text = str(gl.goldenflowers)
	$"chromaf count".text = str(gl.chromaflowers)
	$"life count".text = str(gl.lives)
