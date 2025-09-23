extends Node2D

# input event actions: UP DOWN LEFT RIGHT
# ^ possible notes/things
var PotentialSteps = ["UP", "DOWN", "LEFT","RIGHT"]

# sequence = an array of all the notes in order for this tune/minigame/thing,
# simple eg:
#["LEFT","DOWN","LEFT", "UP","RIGHT","UP", "DOWN","LEFT","DOWN", "RIGHT","UP","RIGHT"] 
# the sequence is 12 steps long

#["UP","DOWN","RIGHT","LEFT", "RIGHT","LEFT","DOWN","UP", "DOWN","UP","LEFT","RIGHT"]

# "step" = where we're up to in the sequence numerically
# "note" = sequence[step], 
# if the player inputs an event action that isn't note, restart,
# if they input correctly (eg press "LEFT" when next=="LEFT"), step+=1
# careful to give a bit of time, like maybe you have 0.5 second cooldown
# between the correct input pressed/released and when it goes to next step
var songs = [
	["LEFT","DOWN","LEFT", "UP","RIGHT","UP", "DOWN","LEFT","DOWN", "RIGHT","UP","RIGHT"], 
	["UP","DOWN","RIGHT","LEFT", "RIGHT","LEFT","DOWN","UP", "DOWN","UP","LEFT","RIGHT"],
	# or randomize.
	]

var sequence: Array[String] = []
var step = 0

func _ready():
	RandomNewSong()
	
func RandomNewSong():
	var NewSong: Array[String]
	var UsableSteps = ["UP", "DOWN", "LEFT", "RIGHT"]
	var chosen = PotentialSteps.pick_random()
	# WHAT I WANT THIS TO DO:
	# first, pick a random step from PotentialSteps,
	# add that to the new song,
	# remove it from the possible options so there's no double ups,
	# randomize the next step from the remaining three options,
	# add the previous/first step back to the options, (so all the potential steps are in there)
	# remove the next step from the options
	# randomize from the 3 possible options and repeat until there are 12 steps in the song
	
	# UsableSteps = PotentialSteps
	#if UsableSteps.has(chosen):
	#	UsableSteps.erase(chosen)
	#print("UsableSteps = " + str(UsableSteps))
	#print("chosen = " + str(chosen))
	#NewSong.append(chosen)
	#print("New Song = " + str(NewSong))
	#chosen = UsableSteps.pick_random()
	#UsableSteps = PotentialSteps
	#if UsableSteps.has(chosen):
	#	UsableSteps.erase(chosen)
	
