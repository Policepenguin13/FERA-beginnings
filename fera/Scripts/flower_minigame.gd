extends Node2D

# @onready var scene = preload("res://Scenes/flower.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in $flowers.get_children():
		child.PlusOneFlower.connect(PlusOne)
		# print("connected " + str(child.name) + "'s PlusOneFlower to PlusOne")
	$"+1".hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func PlusOne():
	if $wait.is_stopped():
		# print("+1!")
		$"+1".position = $Gatherer.position
		$"+1".show()
		$wait.start()
		await $wait.timeout
		$"+1".hide()
	else:
		# print("wait is stopped")
		pass
