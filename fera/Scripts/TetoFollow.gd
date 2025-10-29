extends AnimatedSprite2D

var TileSize = 16
var from = Vector2.ZERO
var to = Vector2.ZERO
var AnimeSpeed = 2
var going
var dir
var CheckNeeded
@onready var you = %Player
# Called when the node enters the scene tree for the first time.
func _ready():
	if !%Player.Moving.is_connected(moving):
		%Player.Moving.connect(moving)
	if !%Player.Moved.is_connected(Arrived):
		%Player.Moved.connect(Arrived)
	if !self.animation_finished.is_connected(AnimeDone):
		self.animation_finished.connect(AnimeDone)
	position = position.snapped(Vector2.ONE * TileSize)
	position += Vector2.ONE * TileSize/2

func _process(_delta):
	if Globals.StoryMilestone < 5:
		hide()
	else:
		show()

func moving():
	from = you.global_position
	# print("Teto sees that you're moving from " + str(from))
	# print("FERA thinks you'ree going to: " + str(Globals.MovingTo))
	if from.x < global_position.x:
		# print("X from.x (" + str(from.x) + ") LESS THAN global_position.x ("+ str(global_position.x) +")")
		dir = "left"
	elif from.x > global_position.x:
		# print("X from.x (" + str(from.x) + ") MORE THAN global_position.x ("+ str(global_position.x) +")")
		dir = "right"
	else:
		if from.y < global_position.y:
			dir = "up"
			# print("Y from.y (" + str(from.y) + ") is LESS THAN global_position.y ("+ str(global_position.y) +")")
		elif from.y > global_position.y:
			dir = "down"
			# print("Y from.y (" + str(from.y) + ") is MORE THAN global_position.y ("+ str(global_position.y) +")")
		else:
			print("something is up with your fera's sense of direction")
			
	CheckNeeded = true
	to = you.global_position
	# print("the fera has noticed you arriving to " + str(to))
	var tween = create_tween()
	tween.tween_property(self, "position", from, 0.5).set_trans(Tween.TRANS_SINE)
	going = true
	# print("fera has started moving")
	await tween.finished
	going = false
	# print("fera has finished moving")
	
	# if from.x is less than teto global_position.x, play left
	# if from.x is positive (more than?) relative to teto, play right
	# if from.y is negative (less than) relative to teto, play up
	# if from.y is postive 

func Arrived():
	# print("---arrived is called---")
	CheckDir() 
	
func CheckDir():
	# print("dir being checked")
	if CheckNeeded:
		# print("checking D")
		$Ray.target_position = Vector2(0, 16)
		$Ray.force_raycast_update()
		if $Ray.is_colliding():
			# print("direction is down?")
			dir = "down"
			flip_h = false
			if animation != dir:
				play("down")
		else: 
			# print("checking U")
			$Ray.target_position = Vector2(0, -16)
			$Ray.force_raycast_update()
			if $Ray.is_colliding():
				# print("direction is up?")
				dir = "up"
				flip_h = false
				if animation != dir:
					play("up")
			else:
				# print("checking R")
				$Ray.target_position = Vector2(16, 0)
				$Ray.force_raycast_update()
				if $Ray.is_colliding():
					# print("direction is right?")
					dir = "right"
					flip_h = true
					if animation != dir:
						play("right")
				else:
					# print("checking L")
					$Ray.target_position = Vector2(-16, 0)
					$Ray.force_raycast_update()
					if $Ray.is_colliding():
						# print("direction is left?")
						dir = "left"
						flip_h = false
						if animation != dir:
							play("left")
	# print("done checking")
	CheckNeeded = false

func AnimeDone():
	print("animation finished?")
	if dir == "right":
		flip_h = true
		play("right")
	else:
		flip_h = false
		play(dir)
