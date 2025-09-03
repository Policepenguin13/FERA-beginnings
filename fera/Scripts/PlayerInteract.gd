extends Area2D

var interactable = null

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sight.set_deferred("disabled", false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("INTERACT"):
		if interactable != null:
			Globals.talking = true
			Globals.CanMove = false
			interactable.Interact()
	
func InteractFound(FoundInteractable):
	print("found: " + str(FoundInteractable))
	interactable = FoundInteractable

func InteractLost(LostInteractable):
	print("lost: " + str(LostInteractable))
	interactable = null
