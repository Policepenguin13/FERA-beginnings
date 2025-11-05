extends Control

var GameBegun = false
signal BEGIN

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
	$buttonContainer/cont.grab_focus()

func ToggleVis(thing: Node):
	if thing.visible:
		thing.hide()
		showStart()
	else:
		thing.show()
		hideStart()
		if thing.name == "Credits":
			$Credits/endCredits.grab_focus()

func hideStart():
	$title.hide()
	$buttonContainer.hide()

func showStart():
	$title.show()
	$buttonContainer.show()
	
	$Credits.hide()
	$SavesMenu.hide()
	$Settings.hide()
	$buttonContainer/cont.grab_focus()

func to_save_menu():
	# ToggleVis($SavesMenu)
	# print("STARTING YOUR JOURNEY...")
	$TransB.show()
	$TransT.show()
	$Anime.play("ToGame")
	var fadeOUT = get_tree().create_tween()
	var safekeeping = float(Globals.BgVol)
	# print("safekeeping = " + str(safekeeping))
# 	while Globals.BgVol != 0.001:
# 		Globals.BgVol-0.001
# 		AudioServer.set_bus_volume_linear(idx, Globals.BgVol)
	# print("starting fadeout")
	fadeOUT.tween_property(%bgBar, "value", 0.1, 0.75)
	await fadeOUT.finished
	# print("ended fadeout, stopping")
	fadeOUT.stop()
	await get_tree().create_timer(0.1).timeout
	var fadeIN = get_tree().create_tween()
	# print("started fade in")
	fadeIN.tween_property(%bgBar, "value", safekeeping, 0.75)
	await fadeIN.finished
	# print("finished fading back in, emitting BEGIN")
	# MusicFadeIN.emit()
	BEGIN.emit()
	# print("BEGIN EMITTED")
#	self.PROCESS_MODE_DISABLED
	# get_tree().change_scene_to_file("res://Scenes/game.tscn")

func _on_settings_pressed():
	ToggleVis($Settings)
	$Settings/Panel/settings/other/top/closeSettings.grab_focus()

func _on_credits_pressed():
	ToggleVis($Credits)

func _on_close_settings_pressed():
	showStart()
