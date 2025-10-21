extends Node2D

signal FlowerEnded
# @onready var scene = preload("res://Scenes/flower.tscn")
var score = 0

@export var flower_scene: PackedScene

func _ready():
	# Ready()
	self.hide()
#	for child in $flowers.get_children():
#		child.position = Vector2(0,0)
		
	$Cam.enabled = false
	self.process_mode = PROCESS_MODE_DISABLED

func Ready():
	process_mode = PROCESS_MODE_INHERIT
	$Cam.enabled = true
	score = 0
	
	var counter = 0
	while counter <= 5:
		Plant()
		counter +=1
		# print(counter)
	
	for child in $flowers.get_children():
		if child.is_connected("PlusOneFlower", PlusOne):
			# print("already connected")
			pass
		else:
			child.PlusOneFlower.connect(PlusOne)
			child.FlowerPlucked.connect(Pluck)
		
		child.self_modulate = Color("WHITE")
		# print("connected " + str(child.name) + "'s PlusOneFlower to PlusOne")
	$BIGTIMER.timeout.connect(End)
	$Label.text = "Collect as many flowers as you can before time runs out!"
	$Label.show()

	$wait.start()
	await $wait.timeout
	# print("starting the big timer!!")
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
	# print("+1 score")
	score += 1

func Pluck():
	# print("pluck")
	Plant()

func Plant():
	# print("planting!")
	var bud = flower_scene.instantiate()
	# IF THE FLOWER ISN'T CONNECTED
	if bud.is_connected("PlusOneFlower", PlusOne):
		# print("already connected")
		pass
	else:
		bud.PlusOneFlower.connect(PlusOne)
		bud.FlowerPlucked.connect(Pluck)
	$flowers.add_child(bud)
	
func End():
	get_tree().call_group("flower", "queue_free")
	$Label.text = "Time's up!"
	$Label.show()
	for child in $flowers.get_children():
		child.self_modulate = Color("TRANSPARENT")
	FlowerEnded.emit()
	process_mode = PROCESS_MODE_DISABLED
	
