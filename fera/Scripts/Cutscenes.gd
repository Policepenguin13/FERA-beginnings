extends Control
# controls the cutscenes

var Animations
var ThisCutscene = AnimatedSprite2D
var CutsceneIndex

func _ready():
	hide()
	for child in get_children():
		child.hide()
	%DialogueBox.DialogueEnded.connect(EndOfCutscene)
	%DialogueBox.SayDialogue.connect(Say)

func EndOfCutscene():
	hide()
	for child in get_children():
		child.hide()
	ThisCutscene = null
	Animations = null

func Say():
	if %DialogueBox.cutscene:
		var temp = Animations.size()-1
		if %DialogueBox.count <= temp:
			get_child(CutsceneIndex).show()
			get_child(CutsceneIndex).play(Animations[%DialogueBox.count])
		else:
			print("count("+ str(%DialogueBox.count) + ") > temp (" + str(temp) +"), hiding")
			EndOfCutscene()
	else: 
		# print("cutscene is false/null")
		return

func BiteCutscene():
	show()
	ThisCutscene = $bite
	ThisCutscene.show()
	CutsceneIndex = $bite.get_index()
	Animations = $bite.sprite_frames.get_animation_names()
	print("teto says this is my food, mine, omnomnom")

func DragCutscene():
	show()
	ThisCutscene = $drag
	ThisCutscene.show()
	CutsceneIndex = $drag.get_index()
	Animations = $drag.sprite_frames.get_animation_names()
	print("teto drags food back dramatically")

func FriendCutscene():
	show()
	ThisCutscene = $friend
	ThisCutscene.show()
	CutsceneIndex = $friend.get_index()
	Animations = $friend.sprite_frames.get_animation_names()
	# print("do friend cutscene stuff here")
	
func SplashCutscene():
	show()
	ThisCutscene = $splash
	ThisCutscene.show()
	CutsceneIndex = $splash.get_index()
	Animations = $splash.sprite_frames.get_animation_names()
	print(Globals.FeraName + " used SPLASH!")

func SneezeCutscene():
	show()
	ThisCutscene = $sneeze
	ThisCutscene.show()
	CutsceneIndex = $sneeze.get_index()
	Animations = $sneeze.sprite_frames.get_animation_names()
	print("achoo! sneeze cutscene")

func ToyCutscene():
	show()
	ThisCutscene = $toy
	ThisCutscene.show()
	CutsceneIndex = $toy.get_index()
	Animations = $toy.sprite_frames.get_animation_names()
	print("wholesome playing with toys, lookit the lil guuuyyy")

func FinalCutscene():
	show()
	ThisCutscene = $end
	ThisCutscene.show()
	CutsceneIndex = $end.get_index()
	Animations = $end.sprite_frames.get_animation_names()
	print("it's the FI-NAL CUT-SCENE, insert epic off-key harmonica solo")
	# it's the FI-NAL CUT-SCENE, insert epic off-key harmonica solo

# 0 burrow + food
# 1 emerge
# 2 sniffs roll
# 3 hmph
# 4 sniffs roll
# 5 omnom
# 6 growl
# 7 fade 2 black
# teleport back to mum

# 0 burrow + food
# 1 emerge
# 2 drag food back

# 0 protag beside burrow
# 1 growl / glare
# 2 im sorry i didn't mean to back you into a corner like that, i was just trying to be your friend
# 3 teto pauses / ...
# 4 MUM said i was being impatient and that I should let you come to me,
# 5 i really hope you can forgive me,
# 6 cause i really wanna be your friend...
# 7 !
# 8 does this mean you forgive me?
# 9 happy pause yay
# 10 ...You don't have a name, do you?
# 11 grumble?
# 12 I know! I'll give you one!
# 13 uncertain noise
# NAME CUTSCENE ASK GOES HERE
# 14 I'll call you TETO! what do you think?
# 15 happy noise
# 16 fade to black
