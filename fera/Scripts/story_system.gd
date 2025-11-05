extends Node

func _process(_delta):
	if Globals.StoryMilestone == 0:
		$tutorialBlock.show()
		$tutorialBlock.monitorable = true
		$tutorialBlock/CollisionShape2D.set_deferred("disabled", false)
		$tutorialBlock/StaticBody2D/CollisionShape2D.set_deferred("disabled", false)
	else:
		$tutorialBlock.hide()
		$tutorialBlock/StaticBody2D/CollisionShape2D.set_deferred("disabled", true)
		$tutorialBlock/CollisionShape2D.set_deferred("disabled", true)
		$tutorialBlock.monitorable = false
	if Globals.StoryMilestone == 5:
		$endgameBlock.hide()
		$endgameBlock/StaticBody2D/CollisionShape2D.set_deferred("disabled", true)
		$endgameBlock/CollisionShape2D.set_deferred("disabled", true)
		$endgameBlock.monitorable = false
	else:
		$endgameBlock.show()
		$endgameBlock.monitorable = true
		$endgameBlock/CollisionShape2D.set_deferred("disabled", false)
		$endgameBlock/StaticBody2D/CollisionShape2D.set_deferred("disabled", false)

# STORY SYSTEM
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
