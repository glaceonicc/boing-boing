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
var star1 = false
var star2 = false
var star3 = false
var points = 0
var colorflicker
var spikecycle
var begone = [] # collected coins, defeated enemies
var pause = false

#checkpoint save
var Cstar1 = false
var Cstar2 = false
var Cstar3 = false
var Cpoints = 0
var Cbegone = [] # collected coins, defeated emenies (saved in checkpoint edition)

# level settings
var max_y
var BPM
var lvlname
var lvltime

# game dynamic stuff
var lives = 5
var goldenflowers = 0
var chromaflowers = 0
var stars = 0



signal die
signal kill
signal boing
signal win


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass
