extends Area2D
# COMPLEX INTERACTABLE:

@export var Default: Array[String] = [] # if all else fails
# export other stuff.

func Interact():
	# CHECK STORY STUFF HERE.
	%DialogueBox.Say(Default)
