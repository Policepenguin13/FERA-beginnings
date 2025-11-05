extends Area2D

var interactable = null

signal InteractPressed
# Called when the node enters the scene tree for the first time.
func _ready():
	$Sight.set_deferred("disabled", false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if !Globals.StoryMilestone == 6:
		if Input.is_action_just_pressed("INTERACT"):
			InteractPressed.emit()
			# print("INTERACTABLE = " + str(interactable))
			# await CheckForInteractables()
			if interactable != null:
				Globals.talking = true
				Globals.CanMove = false
				# print("INTERACTING")
				interactable.Interact()

func CheckForInteractables():
	$Check.force_raycast_update()
	if $Check.is_colliding():
		# print("INTERACT CHECK IS COLLIDING")
		var temp = $Check.get_collider()
		# print("COLLIDING WITH " + str(temp) + "?")
		interactable = temp
	else:
		# print("INTERACT CHECK NOT COLLIDING")
		interactable = null

func AutoInteract():
	# print("auto-interacting")
	await CheckForInteractables()
	if interactable != null:
		Globals.talking = true
		Globals.CanMove = false
		interactable.Interact()

func InteractFound(FoundInteractable):
	# print("found: " + str(FoundInteractable))
	interactable = FoundInteractable

func InteractLost(_LostInteractable):
	# print("lost: " + str(LostInteractable))
	interactable = null
	%DialogueBox.count = 0
