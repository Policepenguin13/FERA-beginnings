extends Panel
# for button functionality

# Called when the node enters the scene tree for the first time.
func _ready():
	self.hide()
	$"../inventory".hide()

func _process(_delta):
	if Globals.talking:
		$"../MENU VISIBLE".disabled = true
	else:
		$"../MENU VISIBLE".disabled = false

func _on_menu_visible_toggled(toggled_on):
	if toggled_on: # is true
		self.show()
		Globals.CanMove = false
	else:
		self.hide()
		Globals.CanMove = true



func _on_settings_pressed():
	print("settings pressed!")

func _on_save_pressed():
	print("save button pressed")

func _on_quit_pressed():
	print("quit to main menu button pressed")

func _on_bag_toggled(toggled_on):
	if toggled_on: # is true
		$"../inventory".show()
		$box/help.disabled = true
	else:
		$"../inventory".hide()
		$box/help.disabled = false


func _on_help_pressed():
	print("help button pressed")
	# say {player}: hint for what to do next
