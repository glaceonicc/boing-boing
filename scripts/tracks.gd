extends Node

# ok so i came up with this solution for making the world map.
# each point on the map will have its place in a dictionary in this global script,
# and when the player moves, all the info that it needs is right here. i think it might work.

var current_world = "world0"
var current_point = "p1"

# im not sure if exporting these does anything but im a bit fan of exported variables so yeah.
@export var world0: Dictionary = {
	"p1": {"up" = "p2", "left" = "no", "down" = "no", "right" = "no", "x" = 144, "y" = 144},
	"p2": {"up" = "no", "left" = "p4", "down" = "p1", "right" = "p3", "x" = 144, "y" = 80},
	"p3": {"up" = "p4", "left" = "p2", "down" = "no", "right" = "no", "x" = 208, "y" = 80},
	"p4": {"up" = "p2", "left" = "no", "down" = "no", "right" = "p2", "x" = 112, "y" = 80},
	"p5": {"up" = "p2", "left" = "no", "down" = "no", "right" = "no", "x" = 144, "y" = 144},
	"p6": {"up" = "p2", "left" = "no", "down" = "no", "right" = "no", "x" = 144, "y" = 144},
	"p7": {"up" = "p2", "left" = "no", "down" = "no", "right" = "no", "x" = 144, "y" = 144},
	"p8": {"up" = "p2", "left" = "no", "down" = "no", "right" = "no", "x" = 144, "y" = 144}
}
