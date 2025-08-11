extends Area2D

var TileSize = 16
var inputs = {"RIGHT": Vector2.RIGHT, "LEFT": Vector2.LEFT, "UP": Vector2.UP, "DOWN": Vector2.DOWN}

func _ready():
	position = position.snapped(Vector2.ONE * TileSize)
	position += Vector2.ONE * TileSize/2
	
func _unhandled_input(event):
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(dir)

func move(dir):
	position += inputs[dir] * TileSize
