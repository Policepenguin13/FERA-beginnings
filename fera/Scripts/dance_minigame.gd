extends Node2D

# input event actions: UP DOWN LEFT RIGHT
# ^ possible notes/things

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
var PotentialSteps = ["UP", "DOWN", "LEFT","RIGHT"]
var sequence: Array[String] = []
var step = 0
var note

var InstructorDancing = true
var FirstTime = true
var winning = false

signal DanceOver

func _ready():
	self.hide()
	$Cam.enabled = false
	self.process_mode = PROCESS_MODE_DISABLED

func Ready():
	process_mode = PROCESS_MODE_INHERIT
	$Cam.enabled = true
	# RandomNewSong()
	# sequence = songs.pick_random()
	sequence = ["LEFT","DOWN","LEFT", "UP","RIGHT","UP", "DOWN","LEFT","DOWN", "RIGHT","UP","RIGHT"]
	# print(str(sequence))
	$Cam/ui/fade.set_modulate(Color.TRANSPARENT)
	$Cam/ui/fade.hide()
	for child in $instructions.get_children():
		child.hide()
		child.set_modulate(Color(0.667,0.0,1.0,1.0))
	winning = false
	self.show()
	
	$OneSec.start()
	await $OneSec.timeout
	KimDance()
	

func Restart():
	print("RESTARTING")
	$Cam/ui/fade.color = Color(0.0,0.0,0.0,1.0)
	for child in $instructions.get_children():
		child.hide()
	await Flash()
	step = 0
	UpdateInstructions()
	Ready()

func _process(_delta):
	if !InstructorDancing:
		$"Cam/ui/other turn".hide()
		$"Cam/ui/your turn".show()
		if step > 11:
			# print("you won")
			if !winning:
				YouWin()
			else:
				return
			# print("after await you win")
		else:
			note = sequence[step]
	
		if Input.is_action_just_pressed("DOWN"):
			if $PlayerArt.animation != "down":
				$PlayerArt.flip_h = false
				$PlayerArt.play("down")
		elif Input.is_action_just_pressed("UP"):
			if $PlayerArt.animation != "up":
				$PlayerArt.flip_h = false
				$PlayerArt.play("up")
		elif Input.is_action_just_pressed("LEFT"):
			if $PlayerArt.animation != "left":
				$PlayerArt.flip_h = true
				$PlayerArt.play("left")
		if Input.is_action_just_pressed("RIGHT"):
			if $PlayerArt.animation != "right":
				$PlayerArt.flip_h = false
				$PlayerArt.play("right")

		if Input.is_action_just_released("DOWN"):
			print("down RELEASED")
			checkNote("down")
			$PlayerArt.play("idle")
		elif Input.is_action_just_released("UP"):
			print("up RELEASED")
			checkNote("up")
			$PlayerArt.play("idle")
		elif Input.is_action_just_released("LEFT"):
			print("left RELEASED")
			checkNote("left")
			$PlayerArt.play("idle")
		elif Input.is_action_just_released("RIGHT"):
			print("right RELEASED")
			checkNote("right")
			$PlayerArt.play("idle")
	else:
		$"Cam/ui/other turn".show()
		$"Cam/ui/your turn".hide()
	# await $PlayerArt.animation_finished
	# $PlayerArt.play("idle")
	
	$"Cam/ui/your turn".text = Globals.PlayerName + "'s turn"

func checkNote(released: String):
	if note == released.to_upper():
		print("note (" + str(note) + ") = " +str(released)+ " !! Next!")
		step += 1
		UpdateInstructions()
	else:
		print("note (" + str(note) + ") is NOT " +str(released)+ ", restart")
		Restart()

func UpdateInstructions():
	var list = $instructions.get_children()
	var thing
	if step > 11:
		YouWin()
		thing = sequence[step-1]
	else:
		thing = sequence[step]
	var add = 0
	# print(thing)
	for child in list:
		if step+add > 11:
			child.hide()
		else:
			child.show()
			thing = sequence[step + add]
			# print(str(thing))
			# print(str(child))
			if thing == "DOWN":
				child.rotation_degrees = 180
			elif thing == "RIGHT":
				child.rotation_degrees = 90
			elif thing == "LEFT":
				child.rotation_degrees = 270
			else:
				child.rotation_degrees = 0
			add +=1

func CutsceneInstructions(number: int):
	var list = $instructions.get_children()
	var thing
	# if number > 11:
	# 	return
	# 	thing = sequence[number-1]
	# else:
	#	thing = sequence[number]
	thing = sequence[number]
	var add = 0
	# print(thing)
	for child in list:
		var temp = number+add
		if temp > 11:
			child.hide()
		else:
			child.show()
			thing = sequence[number + add]
			# print(str(thing))
			# print(str(child))
			if thing == "DOWN":
				child.rotation_degrees = 180
			elif thing == "RIGHT":
				child.rotation_degrees = 90
			elif thing == "LEFT":
				child.rotation_degrees = 270
			else:
				child.rotation_degrees = 0
			add +=1

func YouWin():
	winning = true
	print("WOOO YOU WON LETS GOOOO")
	$Cam/ui/fade.color = Color(1.0,1.0,1.0,1.0)
	await Flash()
	DanceOver.emit()
	self.hide()
	process_mode = PROCESS_MODE_DISABLED

func Flash():
	$Cam/ui/fade.show()
	# print("flashy flashy!")
	$Cam/ui/fade.set_modulate(Color.TRANSPARENT)
	var tween = get_tree().create_tween()
	tween.tween_property($Cam/ui/fade, "modulate", Color.WHITE, 0.5)
	
	$PointSix.start()
	await $PointSix.timeout
	tween = get_tree().create_tween()
	tween.tween_property($Cam/ui/fade, "modulate", Color.TRANSPARENT, 0.5)
	$PointSix.start()
	await $PointSix.timeout
	# print("ok we good")
	$Cam/ui/fade.hide()

func RandomNewSong():
	pass
	# var NewSong: Array[String]
	# var UsableSteps = ["UP", "DOWN", "LEFT", "RIGHT"]
	# var chosen = PotentialSteps.pick_random()
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
	

func KimDance():
	$instructions.position = Vector2(0, 0)
	InstructorDancing = true
	$NPCart.play("idle")
	if FirstTime:
		await get_tree().create_timer(0.7).timeout
		
		# for test in sequence:
		# 	print(test)
		var i = 0
		for move in sequence:
			# print(move)
			if move == "LEFT":
				$NPCart.flip_h = true
			else:
				$NPCart.flip_h = false
			$NPCart.play(move.to_lower())
			CutsceneInstructions(i)
			# print(str($NPCart.animation))
			await get_tree().create_timer(0.8).timeout
			if i+1 > sequence.size():
				# print("i (" + str(i) + ") plus one (" + str(i+1) + ") is greater than sequence.size()-1 ("+ str(sequence.size()-1))
				pass
			else:
				i += 1
		
			$NPCart.play("idle")
			$PointThree.start()
			await $PointThree.timeout
	
		$NPCart.play("idle")
		$PointSix.start()
		await $PointSix.timeout
		FirstTime = false
	InstructorDancing = false
	
	$instructions.position = Vector2(-72.0, 64.0)
	UpdateInstructions()
	for child in $instructions.get_children():
		child.set_modulate(Color.WHITE)
	note = sequence[step]
