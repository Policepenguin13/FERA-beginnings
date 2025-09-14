extends Control

func _ready():
	self.show()
	$DialogueBox.hide()
	$Yes.hide()
	$No.hide()
	$DialogueBox/saying.visible_characters = -1
	$DialogueBox/saying.text = "nobody should be reading this"

	# print("{playername}: Hi, {friend}!".format({"playername":Globals.PlayerName, "friend":Globals.FeraName}))
	
func _process(_delta):
	%saying.visible_characters = -1
	$storyUItodelete.text = " " + str(Globals.StoryMilestone)
	
