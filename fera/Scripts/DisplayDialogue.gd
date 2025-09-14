extends PanelContainer

var count = 0
var busyDisplayingSentence = false
var skip

var talker
var RawWords

signal DialogueEnded
signal SayDialogue

var choice = false
var cutscene = false

func Say(words: Array[String], from: Node):
	var betterWords: Array[String] = []
	talker = from
	RawWords = words
	SayDialogue.emit()
	# print(words)
	for thing in words:
		var newThing
		if thing.contains("{player}") and thing.contains("{teto}"):
			newThing = thing.format({"player":Globals.PlayerName, "teto":Globals.FeraName})
			betterWords.append(newThing)
		elif thing.contains("{teto}"):
			newThing = thing.format({"teto":Globals.FeraName})
			betterWords.append(newThing)
		elif thing.contains("{player}"):
			newThing = thing.format({"player":Globals.PlayerName})
			betterWords.append(newThing)
		else:
			betterWords.append(thing)
	# print(betterWords)
	words = betterWords
	# print("count: " + str(count))
	
	self.show()
	$saying.show()
	$saying.text = ""
	
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
		$saying.text = words[count]
		if choice and count == len(words)-1:
			$"../Yes".show()
			$"../No".show()
		# for ch in words[count]:
		# 	%saying.text += ch
			# print("ch = " + str(ch))
		# 	await get_tree().create_timer(0.05).timeout
		# %saying.text = str(words[count]) # stuff
	if choice:
		var temp = count+1
		if temp > len(words)-1:
			count = count
		else:
			count += 1
	else:
		count += 1
		# print("DIALOGUE'S COUNT = " + str(count))

func EndDialogue():
	# print("Dialogue is ending!")
	self.hide()
	DialogueEnded.emit()
	Globals.talking = false
	Globals.CanMove = true
	talker = null
	choice = false
	cutscene = false
	count = 0

func DisplaySentence(sentence):
	$saying.text = ""
	# sentence.replacen("PLAYERNAME", str(Globals.PlayerName))
	for ch in sentence:
		if skip:
			# print("skip")
			$saying.text = sentence
			skip = false
			return
		else:
			$saying.text += ch
			# print("ch = " + str(ch))
			$DisplayTxtTimer.start()
			await $DisplayTxtTimer.timeout
			# PLAY A SOUND HERE!!
	return

func SkipDialogue():
	if $DisplayTxtTimer.time_left != 0:
		#$DisplayTxtTimer.set_paused(true)
		skip = true
