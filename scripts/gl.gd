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

var points = 0 #all of the points below added together

var epoints = 0 # points gained from killing enemies
var bepoints = 0 # points gained from enemy kill combos
var cpoints = 0 # points gained from collecting stuff
var bcpoints = 0 # points gained from hearts on max health
var spoints = 0 # points gained from stars
var tpoints = 0 # points from time left

var colorflicker
var spikecycle
var begone = [] # collected coins, defeated enemies
var pause = false

var a1 = 0 # the flowerbar and chromabar variables
var a2 = 0
var a3 = 0
var a4 = 0

#checkpoint save
var Cstar1 = false
var Cstar2 = false
var Cstar3 = false

var Cepoints = 0
var Cbepoints = 0 
var Ccpoints = 0 
var Cbcpoints = 0 
var Cspoints = 0

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
