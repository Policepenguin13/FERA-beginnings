extends Node2D

signal FlowerEnded
# @onready var scene = preload("res://Scenes/flower.tscn")
var score = 0
# Called when the node enters the scene tree for the first time.

func _ready():
	self.hide()
	for child in $flowers.get_children():
		child.position = Vector2(0,0)
	$Cam.enabled = false
	self.process_mode = PROCESS_MODE_DISABLED

func Ready():
	process_mode = PROCESS_MODE_INHERIT
	$Cam.enabled = true
	score = 0
	for child in $flowers.get_children():
		child.PlusOneFlower.connect(PlusOne)
		child.Ready()
		# print("connected " + str(child.name) + "'s PlusOneFlower to PlusOne")
	$BIGTIMER.timeout.connect(End)
	$Label.text = "Collect as many flowers as you can before time runs out!"
	$Label.show()

	$wait.start()
	await $wait.timeout
	print("starting the big timer!!")
	$BIGTIMER.start(30.0)
	$wait.start(2.0)
	await $wait.timeout
	$Label.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$score.text = str(score)
	$TIME/VALUE.text = str(int($TIME.value)) +"s"
	$TIME.value = $BIGTIMER.time_left
	$TIME.max_value = $BIGTIMER.wait_time

func PlusOne():
	score += 1

func End():
	$Label.text = "Time's up!"
	$Label.show()
	FlowerEnded.emit()
	process_mode = PROCESS_MODE_DISABLED
	
