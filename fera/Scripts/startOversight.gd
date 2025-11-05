extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = PROCESS_MODE_INHERIT
	show()
	$StartMenuCam.enabled = true
	if !$"StartMenuCam/Start Menu".BEGIN.is_connected(begin):
		$"StartMenuCam/Start Menu".BEGIN.connect(begin)
	# print("START MENU")
	
func begin():
	# print("lol")
	$StartMenuCam.enabled = false
	# await $"StartMenuCam/Start Menu".to_save_menu()
	# print(get_parent().name)
	$"..".Go()
