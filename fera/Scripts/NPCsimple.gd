extends Area2D
# SIMPLE NPC: says one or two different things depending on some variables
# like "does the player have Teto following them" but not much else

@export var Default: Array[String] = [] # if all else fails
@export var IfTetoFollow: Array[String] = [] # you have teto with you
@export var IfGoalThisNPC: Array[String] = [] # your goal relates to this NPC

func Interact():
	# CHECK STORY STUFF HERE. eg, export a string 
	# and if 'npc item' == globals.goal, say IfGoalThisNPC
	%DialogueBox.Say(Default)
