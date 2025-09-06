extends Area2D
# COMPLEX INTERACTABLE: says lots of different stuff depending on
# several variables

@export var Default: Array[String] = [] # if all else fails
@export var ZeroTetoIntro: Array[String] = []
@export_group("One")
@export var OneNoFood: Array[String] = []
@export var OneFoodBite: Array[String] = []
@export_group("Two")
@export var TwoNoFood: Array[String] = []
@export var TwoFood: Array[String] = []
@export_group("Three")
@export var ThreeNotDanced: Array[String] = []
@export var ThreeDancedName: Array[String] = []
@export_group("Four")
@export var FourNone: Array[String] = []
@export var FourFlowers: Array[String] = []
@export var FourWater: Array[String] = []
@export var FourToy: Array[String] = []
@export var FourFollow: Array[String] = []
@export_group("Five")
@export var Five: Array[String] = []

func Interact():
	# CHECK STORY STUFF HERE.
	if Globals.StoryMilestone == 0:
		%DialogueBox.Say(ZeroTetoIntro)
		# print("TETO INTRO CUTSCENE TRIGGER")
	elif Globals.StoryMilestone == 1:
		if Globals.BagOrder.has("Sausage Roll"):
			# %DialogueBox.Say(OneFoodBite)
			print("BITE CUTSCENE TRIGGER, also remove sausage")
		else:
			%DialogueBox.Say(OneNoFood)
	
	elif Globals.StoryMilestone == 2:
		if Globals.BagOrder.has("Sausage Roll"):
			%DialogueBox.Say(TwoFood)
		else:
			%DialogueBox.Say(TwoNoFood)
	
	elif Globals.StoryMilestone == 3:
		if Globals.ThreeDanced:
			# %DialogueBox.Say(ThreeDancedName)
			print("TRIGGER NAME CUTSCENE")
		else:
			%DialogueBox.Say(ThreeNotDanced)
	
	elif Globals.StoryMilestone == 4:
		if Globals.FourGoals.has("Toy"):
			# %DialogueBox.Say(FourToy)
			print("TRIGGER TOY CUTSCENE")
		elif Globals.FourGoals.has("Flowers"):
			# %DialogueBox.Say(FourFlowers)
			print("TRIGGER SNEEZE CUTSCENE")
		elif Globals.FourGoals.has("Water"):
			# %DialogueBox.Say(FourWater)
			print("TRIGGER SPLASH CUTSCENE")
		elif Globals.FourGoals.has("Toy") and Globals.FourGoals.has("Flowers") and Globals.FourGoals.has("Water"):
			# %DialogueBox.Say(FourFollow)
			print("FOLLOW CUTSCENE TRIGGER")
		else:
			%DialogueBox.Say(FourNone)
	
	elif Globals.StoryMilestone == 5 or Globals.StoryMilestone == 6:
		%DialogueBox.Say(Five)
	else:
		%DialogueBox.Say(Default)
	
# 0 (TUTORIAL)
# - int w/ burrow, teto intro cutscene
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
