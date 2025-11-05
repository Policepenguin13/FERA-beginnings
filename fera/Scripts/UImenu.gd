extends Panel
# for button functionality

@export var HelpSay: Array[String] = []
var says = ""

signal QuitToMenu

# Called when the node enters the scene tree for the first time.
func _ready():
	self.hide()
	$"../inventory".hide()
	$"../Settings/Panel/settings/other/top/closeSettings".pressed.connect(SettingsClosed)
	

func _process(_delta):
	if Globals.talking:
		$"../MENU VISIBLE".disabled = true
	elif !$"../Tutorial".ended:
		$"../MENU VISIBLE".disabled = true
	else:
		$"../MENU VISIBLE".disabled = false

func _on_menu_visible_toggled(toggled_on):
	if toggled_on: # is true
		self.show()
		Globals.CanMove = false
	else:
		self.hide()
		%inventory.hide()
		$"../Settings".hide()
		Globals.CanMove = true

func _on_settings_pressed():
	# print("settings pressed!")
	$"../Settings".show()
	self.hide()
	%inventory.hide()

func SettingsClosed():
	$"../Settings".hide()
	self.show()

func _on_save_pressed():
	# print("save button pressed")
	pass

func _on_quit_pressed():
	# print("quit to main menu button pressed")
	QuitToMenu.emit()

func _on_bag_toggled(toggled_on):
	if toggled_on: # is true
		$"../inventory".show()
		$box/help.disabled = true
	else:
		$"../inventory".hide()
		$box/help.disabled = false

func _on_help_pressed():
	# print("help button pressed")
	# _on_menu_visible_toggled(vis)
	$"../../../helper".Enable()
	Globals.talking = true
	CloseMenuForDialogue()
	$"../../../interactStuff".interactable = $"../../../helper"
	$"../../../helper".Interact()
	
func CloseMenuForDialogue():
	# print("Close Menu")
	self.hide()
	%inventory.hide()

func _on_close_settings_pressed():
	SettingsClosed()
