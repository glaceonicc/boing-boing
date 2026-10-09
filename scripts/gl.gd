extends Node

# GLOBAL VARIABLES!!! C:

#player dynamic stuff
var play_x
var play_y
var play_pos
var play_elevation
var checkpointnew
var checkpointxy
var active


#level dynamic stuff
var time
var hearts = 3
var star1
var star2
var star3
var points = 0
var colorflicker
var spikecycle

# level settings
var max_y
var BPM
var lvlname

# game dynamic stuff
var lives = 5
var goldenflowers = 0
var stars = 0



signal die
signal kill
signal boing


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass
