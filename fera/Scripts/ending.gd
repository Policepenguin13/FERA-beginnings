extends Area2D

func _process(_delta):
	if has_overlapping_areas():
		var list = get_overlapping_areas()
		# print(str(get_overlapping_areas()) + " areas")
		if list.size() == 1:
			if list[0].name == "Player":
				# print("see player?")
				if %Cutscenes.visible == false:
					%Cutscenes.FinalCutscene()
