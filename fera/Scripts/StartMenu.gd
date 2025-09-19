extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	self.show()
	$Credits.hide()
	$SavesMenu.hide()
	$Settings.hide()
	# if all the Savefiles are empty/default
	$buttonContainer/cont.text = "new game"
	$Settings/Panel/settings/other/top/closeSettings.pressed.connect(_on_close_settings_pressed)
	# else
	# $buttonContainer/cont.text = "continue"

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
	ToggleVis($SavesMenu)

func _on_settings_pressed():
	ToggleVis($Settings)

func _on_credits_pressed():
	ToggleVis($Credits)

func _on_close_settings_pressed():
	showStart()
