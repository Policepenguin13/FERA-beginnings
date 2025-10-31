extends Control

var GameBegun = false
signal BEGIN
signal MusicFade

# Called when the node enters the scene tree for the first time.
func _ready():
	self.show()
	$Credits.hide()
	$SavesMenu.hide()
	$Settings.hide()
	$TransT.hide()
	$TransB.hide()
	if Globals.StoryMilestone != 0:
		$buttonContainer/cont.text = "continue"
	else:
		$buttonContainer/cont.text = "new game"
	
	$Settings/Panel/settings/other/top/closeSettings.pressed.connect(_on_close_settings_pressed)

func ToggleVis(thing: Node):
	if thing.visible:
		thing.hide()
		showStart()
	else:
		thing.show()
		hideStart()

func hideStart():
	$title.hide()
	$buttonContainer.hide()

func showStart():
	$title.show()
	$buttonContainer.show()
	
	$Credits.hide()
	$SavesMenu.hide()
	$Settings.hide()

func to_save_menu():
	# ToggleVis($SavesMenu)
	print("STARTING YOUR JOURNEY...")
	$TransB.show()
	$TransT.show()
	$Anime.play("ToGame")
	MusicFade.emit()
	await get_tree().create_timer(1.5).timeout
	BEGIN.emit()
#	self.PROCESS_MODE_DISABLED
	# get_tree().change_scene_to_file("res://Scenes/game.tscn")

func _on_settings_pressed():
	ToggleVis($Settings)

func _on_credits_pressed():
	ToggleVis($Credits)

func _on_close_settings_pressed():
	showStart()
