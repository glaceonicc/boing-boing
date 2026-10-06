extends Node2D

@export var BPM = 200

func _ready() -> void:
	gl.BPM = BPM

func _process(delta: float) -> void:
	pass
