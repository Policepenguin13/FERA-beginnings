extends AnimatedSprite2D

@export var DefaultAnim: String
var dir = DefaultAnim
var CheckNeeded = true

func _ready():
	self.animation_finished.connect(thing)

func CheckDir():
	# print("dir being checked")
	if CheckNeeded:
		# print("checking D")
		$Ray.target_position = Vector2(position.x, position.y+16)
		$Ray.force_raycast_update()
		if $Ray.is_colliding():
			# print("direction is down?")
			dir = "down"
			if animation != dir:
				play("down")
		else: 
			# print("checking U")
			$Ray.target_position = Vector2(position.x, position.y-16)
			$Ray.force_raycast_update()
			if $Ray.is_colliding():
				# print("direction is up?")
				dir = "up"
				if animation != dir:
					play("up")
			else:
				# print("checking R")
				$Ray.target_position = Vector2(position.x+16, position.y)
				$Ray.force_raycast_update()
				if $Ray.is_colliding():
					# print("direction is right?")
					dir = "right"
					flip_h = true
					if animation != dir:
						play("right")
				else:
				#	print("checking L")
					$Ray.target_position = Vector2(position.x-16, position.y)
					$Ray.force_raycast_update()
					if $Ray.is_colliding():
					#	print("direction is left?")
						dir = "left"
						if animation != dir:
							play("left")
	# print("done checking")
	CheckNeeded = false

func thing():
	print("animation finished?")
	if dir == "right":
		flip_h = true
		play("right")
	else:
		flip_h = false
		play(dir)

func _process(_delta):
	if Globals.CanMove:
		CheckNeeded = true
