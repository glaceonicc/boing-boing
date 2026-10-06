extends Area2D

var BPM
@export var color = true
# true = red false = blue
var flicker = true

func _ready() -> void:
	BPM = gl.BPM
	$timer.wait_time = (60/ (BPM / 8))
	$timer.start()


func _process(delta: float) -> void:
	if color == true:
		if flicker == true:
			$sprite.play("redtrue")
			$hitbox.set_deferred("disabled", false)
		else:
			$sprite.play("redfalse")
			$hitbox.set_deferred("disabled", true)
	else:
		if flicker == true:
			$sprite.play("bluefalse")
			$hitbox.set_deferred("disabled", true)
		else:
			$sprite.play("bluetrue")
			$hitbox.set_deferred("disabled", false)


func _on_timer_timeout() -> void:
	if flicker == true:
		flicker = false
	else:
		flicker = true
