extends Panel
# for button functionality

# Called when the node enters the scene tree for the first time.
func _ready():
	self.hide()

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
	pass # Replace with function body.


func _on_bag_pressed():
	pass # Replace with function body.


func _on_save_pressed():
	pass # Replace with function body.


func _on_quit_pressed():
	pass # Replace with function body.
