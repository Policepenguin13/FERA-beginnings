extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	self.show()
	$Credits.hide()
	$SavesMenu.hide()
	$Settings.hide()
	$TransT.hide()
	$TransB.hide()
	# if all the Savefiles are empty/default
	# $buttonContainer/cont.text = "new game"
	# else
	# $buttonContainer/cont.text = "continue"
	# but for now...
	$buttonContainer/cont.text = "start"
	
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
	await get_tree().create_timer(1.5).timeout
	get_tree().change_scene_to_file("res://Scenes/game.tscn")

func _on_settings_pressed():
	ToggleVis($Settings)

func _on_credits_pressed():
	ToggleVis($Credits)

func _on_close_settings_pressed():
	showStart()
