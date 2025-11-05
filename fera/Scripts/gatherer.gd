extends CharacterBody2D

@export var speed = 150
var dir = "DOWN"
var act = "idle"

func get_input():
	var input_direction = Input.get_vector("LEFT", "RIGHT", "UP", "DOWN")
	velocity = input_direction * speed
	if input_direction == Vector2(0.0,-1.0):
		dir = "UP"
		act = "walk"
	elif input_direction == Vector2(-1.0,0.0):
		dir = "LEFT"
		act = "walk"
	elif input_direction == Vector2(1.0,0.0):
		dir = "RIGHT"
		act = "walk"
	elif input_direction == Vector2(0.0,1.0):
		dir = "DOWN"
		act = "walk"
	else:
		act = "idle"

func _physics_process(_delta):
	get_input()
	move_and_slide()
	
	if Input.is_action_just_pressed("DOWN"):
		$art.flip_h = false
		$art.play("walkDOWN")
	elif Input.is_action_just_pressed("UP"):
		$art.flip_h = false
		$art.play("walkUP")
	elif Input.is_action_just_pressed("RIGHT"):
		$art.flip_h = true
		$art.play("walkRIGHT")
	elif Input.is_action_just_pressed("LEFT"):
		$art.flip_h = false
		$art.play("walkLEFT")


func _on_art_animation_finished():
	$art.play("idle" + dir)
