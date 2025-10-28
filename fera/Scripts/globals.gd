extends Node

var talking = false
var CanMove = true

var MovingTo

# set to RIN and TETO by default
var PlayerName: String = "RIN"
var FeraName: String = "TETO"

# inventory
var BagAmounts: Dictionary[String, int] = {}
var BagOrder: Array[String] = []
var funds: int = 0

# story
var StoryMilestone: int = 0

var ThreeDanced = false
var ThreeNameHappened = false
var FourGoals: Array[String] = []
# if BagOrder has Toy or Water, add to this

# STORY SYSTEM
# 0 (TUTORIAL)
# - int w/ burrow, teto intro cutscene
# 1 (FOOD) OK BUT WHAT IF INSTEAD, TETO INTRO AND BITE WERE THE SAME?
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
