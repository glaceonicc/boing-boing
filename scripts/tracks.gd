extends Node

# ok so i came up with this solution for making the world map.
# each point on the map will have its place in a dictionary in this global script,
# and when the player moves, all the info that it needs is right here. i think it might work.

var current_world = "world0"
var current_point = "p1"
var current_world_scene = ""
var current_world_name = ""

# im not sure if exporting these does anything but im a bit fan of exported variables so yeah.
@export var world0: Dictionary = {
	"p1": {"up" = "p2", "left" = "no", "down" = "no", "right" = "no", "x" = 144, "y" = 144, "locked" = [], "thing" = ""},
	"p2": {"up" = "no", "left" = "p4", "down" = "p1", "right" = "p3", "x" = 144, "y" = 80, "locked" = [], "thing" = ""},
	"p3": {"up" = "p5", "left" = "p2", "down" = "no", "right" = "no", "x" = 208, "y" = 80, "locked" = ["up"], "thing" = "level", "stuff" = "res://levels/0-4.tscn"},
	"p4": {"up" = "no", "left" = "no", "down" = "no", "right" = "p2", "x" = 112, "y" = 80, "locked" = [], "thing" = "level", "stuff" = "res://levels/0-0.tscn"},
	"p5": {"up" = "no", "left" = "p6", "down" = "p3", "right" = "no", "x" = 208, "y" = 16, "locked" = [], "thing" = ""},
	"p6": {"up" = "p7", "left" = "no", "down" = "p8", "right" = "p5", "x" = 64, "y" = 16, "locked" = [], "thing" = ""},
	"p7": {"up" = "p9", "left" = "no", "down" = "p6", "right" = "no", "x" = 64, "y" = 0, "locked" = [], "thing" = ""},
	"p8": {"up" = "p6", "left" = "no", "down" = "p10", "right" = "no", "x" = 64, "y" = 32, "locked" = [], "thing" = ""},
	"p9": {"up" = "no", "left" = "no", "down" = "p7", "right" = "no", "x" = 64, "y" = -16, "locked" = [], "thing" = ""},
	"p10": {"up" = "p8", "left" = "no", "down" = "no", "right" = "no", "x" = 64, "y" = 48, "locked" = [], "thing" = ""}
}
