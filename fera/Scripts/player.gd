extends Area2D

var TileSize = 16
var inputs = {"RIGHT": Vector2.RIGHT, "LEFT": Vector2.LEFT, "UP": Vector2.UP, "DOWN": Vector2.DOWN}
@onready var ray = $collideCheck
# @onready var Eyes = $interactCheck
var AnimeSpeed = 2
var moving = false
var CanMove = true
var DIRECTION = "RIGHT"

signal Moving
signal Moved

func _ready():
	position = position.snapped(Vector2.ONE * TileSize)
	position += Vector2.ONE * TileSize/2
	$interactStuff/Sight.rotation = 0.0
	Teleport(Vector2(-144,56), "DOWN")
	
#func _unhandled_input(event):
#	if moving:
#		return
#	if Globals.CanMove == false:
		# print("No moving yet!")
#		return
#	for dir in inputs.keys():
#		if event.is_action_pressed(dir):
#			DIRECTION = dir
#			print("going!")
#			Go(event)
			# print("check if event is still pressed")

func Go():
	# print("player is at " + str(global_position))
	AnimeWalk(DIRECTION)
	await Move(DIRECTION)
	

func _process(_delta):
	if moving:
		return
	if Globals.CanMove == false:
		# print("No moving yet!")
		return
	for dir in inputs.keys():
		if Input.is_action_pressed(dir):
			DIRECTION = dir
			await Go()

func Move(dir):
	# position += inputs[dir] * TileSize
	ray.target_position = inputs[dir] * TileSize
	ray.force_raycast_update()
	if !ray.is_colliding():
		# position += inputs[dir] * TileSize
		# print("MOVE start")
		Globals.MovingTo = position + inputs[dir] * TileSize
		# print("SET MovingTo TO: " + str(Globals.MovingTo))
		Moving.emit()
		var tween = create_tween()
		tween.tween_property(self, "position", position + inputs[dir] *    TileSize, 0.75/AnimeSpeed).set_trans(Tween.TRANS_SINE)
		moving = true
		await tween.finished
		moving = false
		Moved.emit()
		# print("player is at " + str(global_position))
		# CHECK IF PLAYER IS STILL HOLDING BUTTON DOWN, MOVE IF SO
		# print("MOVE end")

func AnimeWalk(dir):
	$art.flip_h = false
	if dir == "UP":
		$art.play("walkUP")
		$interactStuff/Sight.rotation_degrees = 180.0
		$interactStuff/Check.rotation_degrees = 180.0
	elif dir == "DOWN":
		$art.play("walkDOWN")
		$interactStuff/Sight.rotation_degrees = 0.0
		$interactStuff/Check.rotation_degrees = 0.0
	elif dir == "RIGHT":
		$art.flip_h = true
		$art.play("walkRIGHT")
		$interactStuff/Sight.rotation_degrees = 270.0
		$interactStuff/Check.rotation_degrees = 270.0
	elif dir == "LEFT":
		$art.play("walkLEFT")
		$interactStuff/Sight.rotation_degrees = 90.0
		$interactStuff/Check.rotation_degrees = 90.0

func Teleport(pos: Vector2, facing: String):
	# print("teleport to " + str(pos) + " facing " + facing)
	position = pos
	position = position.snapped(Vector2.ONE * TileSize)
	position += Vector2.ONE * TileSize/2
	# print("rotating?")
	DIRECTION = facing
	if DIRECTION == "UP":
		$interactStuff/Sight.rotation_degrees = 180.0
		$interactStuff/Check.rotation_degrees = 180.0
	elif DIRECTION == "DOWN":
		$interactStuff/Sight.rotation_degrees = 0.0
		$interactStuff/Check.rotation_degrees = 0.0
	elif DIRECTION == "RIGHT":
		$interactStuff/Sight.rotation_degrees = 270.0
		$interactStuff/Check.rotation_degrees = 270.0
	elif DIRECTION == "LEFT":
		$interactStuff/Sight.rotation_degrees = 90.0
		$interactStuff/Check.rotation_degrees = 90.0

func _on_art_animation_finished():
	var animeName
	if DIRECTION == "RIGHT":
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
