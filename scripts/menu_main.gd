extends Node2D

# main  menus

func _ready() -> void:
	$play.connect("pressed", play)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func play():
	get_tree().change_scene_to_file("res://levels/0-4.tscn")
