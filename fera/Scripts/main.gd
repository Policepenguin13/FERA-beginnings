extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	if !$"StartMenu/StartMenuCam/Start Menu".BEGIN.is_connected(Go):
		$"StartMenu/StartMenuCam/Start Menu".BEGIN.connect(Go)

func Go():
	print("Go")
#	$StartMenu.PROCESS_MODE_DISABLED
#	$Game.PROCESS_MODE_INHERIT
	if Globals.StoryMilestone == 0:
		$Game.Ready()
