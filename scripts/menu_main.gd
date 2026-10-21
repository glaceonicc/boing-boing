extends Node2D

# main  menus

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/0-4.tscn")

func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://menu/menu_credits.tscn")

func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://menu/menu_settings.tscn")
