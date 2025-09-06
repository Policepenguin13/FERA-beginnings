extends Control

func _ready():
	hide()
	for child in get_children():
		child.hide()

func EndOfCutscene():
	hide()
	for child in get_children():
		child.hide()

func BiteCutscene():
	show()
	$bite.show()
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
