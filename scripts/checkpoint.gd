extends Area2D

@export var checkpoint_number = 1

var trigger = false

func _ready() -> void:
	$sprite.play("closed")

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("collect") and trigger == false:
		trigger = true
		$sprite.play("open")
		gl.checkpointnew = true
		gl.checkpointxy = position
		gl.Cstar1 = gl.star1
		gl.Cstar2 = gl.star2
		gl.Cstar3 = gl.star3
		
		gl.Cepoints = gl.epoints
		gl.Cbepoints = gl.bepoints
		gl.Ccpoints = gl.cpoints 
		gl.Cbcpoints = gl.bcpoints 
		gl.Cspoints = gl.spoints
		
		gl.Cbegone += gl.begone
		gl.begone.clear()
		
		if gl.hearts < 3:
			gl.hearts += 1
		else:
			gl.bcpoints += 1000
