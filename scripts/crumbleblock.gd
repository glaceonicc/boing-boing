extends Area2D

#coding this caused me so much trouble just because i forgot you have to turn one shot on

var broken = false
var inside = false

func _ready() -> void:
	$sprite.play("default")

func _process(delta: float) -> void:
	if inside == true and gl.play_elevation == 0 and broken == false:
		$timer.start()
		$sprite.play("crack")
		broken = true


func _on_timer_timeout() -> void:
	$sprite.play("ows")
	$hitbox.set_deferred("disabled", true)
	$back.start()



func _on_detect_area_entered(area: Area2D) -> void:
	if area.is_in_group("g"):
		inside = true

func _on_detect_area_exited(area: Area2D) -> void:
	if area.is_in_group("g"):
		inside = false


func _on_back_timeout() -> void:
	$hitbox.set_deferred("disabled", false)
	broken = false
	$sprite.play("default")
