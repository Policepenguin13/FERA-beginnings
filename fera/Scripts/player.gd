extends Area2D

var TileSize = 16
var inputs = {"RIGHT": Vector2.RIGHT, "LEFT": Vector2.LEFT, "UP": Vector2.UP, "DOWN": Vector2.DOWN}
@onready var ray = $collideCheck
# @onready var Eyes = $interactCheck
var AnimeSpeed = 2
var moving = false
var CanMove = true
var DIRECTION = "DOWN"


func _ready():
	position = position.snapped(Vector2.ONE * TileSize)
	position += Vector2.ONE * TileSize/2
	$interactStuff/Sight.rotation = 0.0
	
func _unhandled_input(event):
	if moving:
		return
	if Globals.CanMove == false:
		# print("No moving yet!")
		return
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			Move(dir)
			AnimeWalk(dir)
			DIRECTION = dir

func Move(dir):
	# position += inputs[dir] * TileSize
	ray.target_position = inputs[dir] * TileSize
	ray.force_raycast_update()
	if !ray.is_colliding():
		# position += inputs[dir] * TileSize
		var tween = create_tween()
		tween.tween_property(self, "position", position + inputs[dir] *    TileSize, 1.0/AnimeSpeed).set_trans(Tween.TRANS_SINE)
		moving = true
		await tween.finished
		moving = false

func AnimeWalk(dir):
	$art.flip_h = false
	if dir == "UP":
		$art.play("walkUP")
		$interactStuff/Sight.rotation_degrees = 180.0
	elif dir == "DOWN":
		$art.play("walkDOWN")
		$interactStuff/Sight.rotation_degrees = 0.0
	elif dir == "RIGHT":
		$art.play("walkRIGHT")
		$interactStuff/Sight.rotation_degrees = 270.0
	elif dir == "LEFT":
		$art.flip_h = true
		$art.play("walkLEFT")
		$interactStuff/Sight.rotation_degrees = 90.0


func _on_art_animation_finished():
	var animeName
	if DIRECTION == "LEFT":
		$art.flip_h = true
	else:
		$art.flip_h = false
	
	if !moving:
		animeName = "idle" + str(DIRECTION)
	else:
		animeName = "walk" + str(DIRECTION)
	# print(animeName)
	$art.play(animeName)
	# print(str($art.animation))
