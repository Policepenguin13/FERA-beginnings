extends Area2D
# SIMPLE NPC: says one or two different things depending on some variables
# like "does the player have Teto following them" but not much else
  
@export var Default: Array[String] = [] # if all else fails
@export var TetoFollow: Array[String] = [] # you have teto with you
@export var OneNoSausage: Array[String] = []
@export var OneYesSausage: Array[String] = []
@export var TwoRequest: Array[String] = []
@export var TwoNoSausageNoFlowers: Array[String] = []
@export var TwoNoSausageYesFlowers: Array[String] = []
@export var TwoYesSausageYesFlowers: Array[String] = []

var Requested = false

func _ready():
	%DialogueBox.DialogueEnded.connect(end)
	Requested = false

func end():
	# print("burrow notices that the dialogue has ended")
	if %DialogueBox.talker != self:
		# print("but you are not talking to burrow")
		pass
	else:
		# print("you were talking to burrow!")
		if %DialogueBox.RawWords == OneNoSausage:
			print("said one no sausage, +1 sausage")
			%inventory.AddItem("Sausage Roll")
		elif %DialogueBox.RawWords == TwoRequest:
			Requested = true
		elif %DialogueBox.RawWords == TwoNoSausageYesFlowers:
			%inventory.AddItem("Sausage Roll")
			
			%inventory.RemoveItem("Flower")# 1
			%inventory.RemoveItem("Flower")# 2
			%inventory.RemoveItem("Flower")# 3
			%inventory.RemoveItem("Flower")# 4
			%inventory.RemoveItem("Flower")# 5
			%inventory.RemoveItem("Flower")# 6
			%inventory.RemoveItem("Flower")# 7
			%inventory.RemoveItem("Flower")# 8
			%inventory.RemoveItem("Flower")# 9
			%inventory.RemoveItem("Flower")# 10
			
func Interact():
	if Globals.StoryMilestone ==1:
		if Globals.BagOrder.has("Sausage Roll"):
			%DialogueBox.Say(OneYesSausage, self)
		else:
			%DialogueBox.Say(OneNoSausage, self)
	elif Globals.StoryMilestone == 2:
		if Requested:
			%DialogueBox.Say(TwoRequest, self)
		else:
			if Globals.BagOrder.has("Sausage Roll"):
				%DialogueBox.Say(TwoYesSausageYesFlowers, self)
			else:
				if Globals.BagOrder.has("Flower"):
					var flowers = Globals.BagAmounts.get("Flower")
					if flowers >= 10:
						%DialogueBox.Say(TwoNoSausageYesFlowers, self)
					else:
						%DialogueBox.Say(TwoNoSausageNoFlowers, self)
	elif Globals.StoryMilestone >= 4:
		%DialogueBox.Say(Default, self)
	elif Globals.StoryMilestone <= 5:
		%DialogueBox.Say(TetoFollow, self)
