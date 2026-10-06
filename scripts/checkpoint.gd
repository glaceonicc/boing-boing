extends Area2D

@export var checkpoint_number = 1

var trigger = false

func _ready() -> void:
	$sprite.play("closed")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("collect"):
		var trigger = false
		$sprite.play("open")
		gl.checkpointnew = true
		gl.checkpointxy = position
