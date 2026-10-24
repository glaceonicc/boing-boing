extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tracks.current_world_name = "W0: TEST WORLD"
	tracks.current_world_scene = "res://world0.tscn"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
