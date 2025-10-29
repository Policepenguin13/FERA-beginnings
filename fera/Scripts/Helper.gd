extends Area2D

@export var HelpSay: Array[String] = []
var says = ""

func _ready():
	# monitorable = false
	$"..".Moved.connect(moved)
	moved()
	Disable()
	%DialogueBox.DialogueEnded.connect(end)

func end():
	if %DialogueBox.talker == self:
		Disable()
#	$"../interactStuff".InteractLost(self)

func moved():
	if $"..".DIRECTION == "UP":
		global_position.y = $"..".global_position.y - $"..".TileSize
		global_position.x = $"..".global_position.x
	if $"..".DIRECTION == "DOWN":
		global_position.y = $"..".global_position.y + $"..".TileSize
		global_position.x = $"..".global_position.x
	
	if $"..".DIRECTION == "RIGHT":
		global_position.x = $"..".global_position.x + $"..".TileSize
		global_position.y = $"..".global_position.y
	if $"..".DIRECTION == "LEFT":
		global_position.x = $"..".global_position.x - $"..".TileSize
		global_position.y = $"..".global_position.y

func Enable():
	# print("enable interactable here")
	show()
	$sight.disabled = false
	# monitorable = true
	# Interact()

func Disable():
	# print("disable interactacle here")
	hide()
	$sight.disabled = true
	position += Vector2(300, 20)
		# $"../interactStuff".InteractLost(self)

func Interact():
	HelpSay.clear()
	says = ""
	# say {player}: hint for what to do next
	
	if Globals.StoryMilestone == 0:
		says = "{player}: I should find what that noise was. It came from somewhere up the path in the woods."
		# print(says)
		HelpSay.append(says)
	if Globals.StoryMilestone == 1:
		if Globals.BagOrder.has("Sausage Roll"):
			says = "{player}: I should take this food back to the Fera in that burrow."
			# print(says)
			HelpSay.append(says)
		else:
			says = "{player}: I should see if SHOPKEEPER has any food. He should be at his shop in town."
			# print(says)
			HelpSay.append(says)
	if Globals.StoryMilestone == 2:
		if %NPCs/Shopkeeper.Requested:
			if Globals.BagOrder.has("Sausage Roll"):
				says = "{player}: I should give this Sausage Roll to the Fera in the burrow."
				# print(says)
				HelpSay.append(says)
			else:
				if Globals.BagOrder.has("Flower"):
					if Globals.BagAmounts["Flower"] >= 10:
						says = "{player}: I should take these Flowers back to SHOPKEEPER."
						# print(says)
						HelpSay.append(says)
					else:
						says = "{player}: SHOPKEEPER wanted 10 Flowers, I'll need some more."
						# print(says)
						HelpSay.append(says)
				else:
					says = "{player}: FLORIST FLORA up the road from the shop can help me get flowers."
					# print(says)
					HelpSay.append(says)
		else:
			says = "{player}: I should ask SHOPKEEPER about getting another sausage roll."
			# print(says)
			HelpSay.append(says)
	if Globals.StoryMilestone == 3:
		if Globals.ThreeDanced:
			if Globals.ThreeNameHappened:
				says = "{player}: I should check in with MUM at our house. It's down the road from the shop."
				# print(says)
				HelpSay.append(says)
			else:
				says = "{player}: I should talk to the Fera in the burrow now that I'm feeling better."
				# print(says)
				HelpSay.append(says)
		else:
			says = "{player}: I feel bad, I should go do some dancing to cheer up. I saw DANCER KIM by the fence near the shop."
			# print(says)
			HelpSay.append(says)
	if Globals.StoryMilestone == 4:
		if Globals.FourGoals.has("Toy"):
			if !%NPCs/Burrow.FourCutscenesShown.has("Toy"):
				# print("{player}: I should take this toy to the burrow.")
				FourBurrow()
		else:
			says = "{player}: I can get a toy for the Fera to play with from KID TIMMY, who's up behind our house."
			# print(says)
			HelpSay.append(says)
		
		if Globals.FourGoals.has("Water"):
			if !!%NPCs/Burrow.FourCutscenesShown.has("Water"):
				FourBurrow()
		else:
			says = "{player}: I can get a bowl of water from the tap beside my house."
			# print(says)
			HelpSay.append(says)
		
		if Globals.FourGoals.has("Flower"):
			if !%NPCs/Burrow.FourCutscenesShown.has("Flower"):
				FourBurrow()
		else:
			says = "{player}: I can get a flower from FLORIST FLORA up the road from the shop to give to the Fera."
			# print(says)
			HelpSay.append(says)
	if Globals.StoryMilestone == 5:
		if %NPCs/Mum.SaidYouCanGo:
			says = "{player}: I can start on my adventure down the road from my house, on TRAIL 01!"
			# print(says)
			HelpSay.append(says)
		else:
			says = "{player}: I should talk to MUM about going on an adventure!"
			# print(says)
			HelpSay.append(says)
	
	%DialogueBox.Say(HelpSay, self)

# this one is called for the "i take this to the burrow" if FourGoals has Toy/Flower/Water
func FourBurrow():
	# print("{player}: I should take this toy, water bowl and flower to the burrow.")
	if Globals.FourGoals.size() == 1:
		says = str("{player}: I should take this " + str(Globals.FourGoals[0]).to_lower() + " to the burrow.")
		# print(says)
	elif Globals.FourGoals.size() == 2:
		says = str("{player}: I should take this " + str(Globals.FourGoals[0]).to_lower() + " and " + str(Globals.FourGoals[1]).to_lower() + " to the burrow.")
		# print(says)
		HelpSay.append(says)
	else:
		says = str("{player}: I should take this " + str(Globals.FourGoals[0]).to_lower() + ", " + str(Globals.FourGoals[1]).to_lower() + " and " + str(Globals.FourGoals[2]).to_lower() + " to the burrow.")
		# print(says)
		HelpSay.append(says)


# STORY 
# 0 (TUTORIAL)
# - int w/ burrow, teto intro
# 1 (FOOD) 
#		. go to shopkeep, get sausage
# - int w/ burrow when you have a sausage, bite cutscene
# 2 (APOLOGY SAUSAGE + FLOWERS)
#		. go to shopkeep, he says "go get flowers"
#		. get flowers via minigame
#		. back to shopkeep, get sausage
# - int w/ burrow when you have sausage and flowers
# 3 (MUSIC REFERENCE HERE)
#		. dance minigame
# - int w/ burrow once you've danced, name cutscene
# 4 (WATER, FLOWER, TOY, IN ANY ORDER)
#		flower
#			.get flowers via minigame
#			.back to burrow, sneeze cutscene
#		water
#			.interact with pump (maybe 3 times, maybe timing minigame)
#			.back to burrow, splash cutscene
#		toy
#			.interact with timmy
#			.back to burrow, toy cutscene
# - after the last flower/water/toy cutscene, follow cutscene!

# 5 (JUST BEFORE THE END)
#		.int w/ mum
#		.optionally do other stuff
# - walk to trail 01
# 6 (THE END), you completed the game!
