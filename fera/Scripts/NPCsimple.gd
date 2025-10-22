extends Area2D
# SIMPLE NPC: says one or two different things depending on some variables
# like "does the player have Teto following them" but not much else
  
@export var Default: Array[String] = [] # if all else fails
@export var IfTetoFollow: Array[String] = [] # you have teto with you
@export var IfGoalThisNPC: Array[String] = [] # NPC gives you goal
@export var IfGoalAchieved: Array[String] = [] # goal has been given
@export var GoalNeeded = false
@export var GoalMilestone: int
@export var Goal: String = ""

func _ready():
	%DialogueBox.DialogueEnded.connect(end)
	
func end():
	if %DialogueBox.talker != self:
		pass
	else:
		if %DialogueBox.RawWords == IfGoalThisNPC:
			%inventory.AddItem(Goal)

func Interact():
	$art.CheckDir()
	# CHECK STORY STUFF HERE. eg, export a string 
	# and if 'npc item' == globals.goal, say IfGoalThisNPC
	if GoalNeeded:
		# print("this npc can give you item")
		if Globals.StoryMilestone == GoalMilestone:
			# print("you're at the right milestone for item to be given")
			if Globals.BagOrder.has(Goal):
				%DialogueBox.Say(IfGoalAchieved, self)
			else:
				%DialogueBox.Say(IfGoalThisNPC, self)
		else:
			if Globals.StoryMilestone <= 4:
				%DialogueBox.Say(Default, self)
			elif Globals.StoryMilestone >= 5:
				%DialogueBox.Say(IfTetoFollow, self)
	elif Globals.StoryMilestone <= 4:
		%DialogueBox.Say(Default, self)
	elif Globals.StoryMilestone >= 5:
		%DialogueBox.Say(IfTetoFollow, self)
	# %DialogueBox.Say(Default)
