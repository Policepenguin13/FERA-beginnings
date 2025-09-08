extends Control

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
		get_child(CutsceneIndex).play(Animations[%DialogueBox.count])
	else: 
		return

func BiteCutscene():
	show()
	ThisCutscene = $bite
	CutsceneIndex = $bite.get_index()
	Animations = $bite.sprite_frames.get_animation_names()
	print("teto says this is my food, mine, omnomnom")

func DragCutscene():
	show()
	$drag.show()
	print("teto drags food back dramatically")

func FriendCutscene():
	show()
	$friend.show()
	print("do friend cutscene stuff here")
	NameCutscene()

func NameCutscene():
	show()
	$friend.hide()
	$name.show()
	print("ask fera name question here")

func SplashCutscene():
	show()
	$splash.show()
	print(Globals.FeraName + " used SPLASH!")

func SneezeCutscene():
	show()
	$sneeze.show()
	print("achoo! sneeze cutscene")

func ToyCutscene():
	show()
	$toy.show()
	print("wholesome playing with toys, lookit the lil guuuyyy")

func FinalCutscene():
	show()
	$end.show()
	# it's the FI-NAL CUT-SCENE, insert epic off-key harmonica solo
