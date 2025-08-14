extends Area2D

@export var Default: Array[String] = []
@export var PartOne: Array[String] = []

var count = 0
var busyDisplayingSentence = false
var skip

# @onready var TalkingBox = $"../Player/Cam/UI/DialogueBox"
# @onready var saying = $"../Player/Cam/UI/DialogueBox/saying"

func _ready():
	$Label.text = "hi"

func SayNext():
	var words
	words = Default
	# print(words)
	# print("count: " + str(count))
	# check player's story-progress to decide which lines to use
	
	%DialogueBox.show()
	%saying.show()
	$Label.text = "spitefully"
	%saying.text = ""
	
	if busyDisplayingSentence:
		skip = true
		return
	
	if count > len(words)-1:
		# print("count ("+str(count)+") greater than len(words) ("+str(len(words))+") !")
		EndDialogue()
		return
	else:
		# print("count ("+str(count)+") less than len(words) ("+str(len(words))+") !")
		# print(words[count])
		busyDisplayingSentence = true
		await DisplaySentence(words[count])
		busyDisplayingSentence = false
		%saying.text = words[count]
		# for ch in words[count]:
		# 	%saying.text += ch
			# print("ch = " + str(ch))
		# 	await get_tree().create_timer(0.05).timeout
		# %saying.text = str(words[count]) # stuff
	count += 1

func EndDialogue():
	# print("Dialogue is ending!")
	%DialogueBox.hide()
	# self.hide()
	Globals.talking = false
	count = 0

func DisplaySentence(sentence):
	%saying.text = ""
	for ch in sentence:
		if skip:
			# print("skip")
			%saying.text = sentence
			skip = false
			return
		else:
			%saying.text += ch
			# print("ch = " + str(ch))
			$DisplayTxtTimer.start()
			await $DisplayTxtTimer.timeout
			# PLAY A SOUND HERE!!
	return

func SkipDialogue():
	if $DisplayTxtTimer.time_left != 0:
		#$DisplayTxtTimer.set_paused(true)
		skip = true
