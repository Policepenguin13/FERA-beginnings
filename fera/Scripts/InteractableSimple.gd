extends Area2D
# SIMPLE interactable: only ever says one thing.
# This is for objects like signs, doors and other stuff.

@export var Default: Array[String] = []
# @export var PartOne: Array[String] = []

func Interact():
	%DialogueBox.Say(Default, self)
