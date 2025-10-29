extends Label

var ended = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$"../Ask".asked.connect(Begin)
	ended = false
	hide()

func Begin():
	if $"../Ask".ProtagVer:
		self.modulate = Color.TRANSPARENT
		await get_tree().create_timer(0.5).timeout
		
		var tween = get_tree().create_tween()
		tween.tween_property(self, "modulate", Color.WHITE, 0.5)
		
		text = "Arrow keys or WASD to move"
		show()
		# print("before await move")
		await $"../../..".Moved
		# print("after await move")
		
		tween = get_tree().create_tween()
		tween.tween_property(self, "modulate", Color.TRANSPARENT, 0.5)
	
		await get_tree().create_timer(0.6).timeout
		# print("after tween")
		text = "E, spacebar or Enter to interact and continue dialogue"
	
		tween = get_tree().create_tween()
		tween.tween_property(self, "modulate", Color.WHITE, 0.5)
	
		await get_tree().create_timer(0.6).timeout
	
		await $"../../../interactStuff".InteractPressed
		# print("interaction complete")
	
		tween = get_tree().create_tween()
		tween.tween_property(self, "modulate", Color.TRANSPARENT, 0.5)
	
		await get_tree().create_timer(0.6).timeout
		text = "Tutorial Complete. Good luck!"
	
		tween = get_tree().create_tween()
		tween.tween_property(self, "modulate", Color.WHITE, 0.5)
		await get_tree().create_timer(3.0).timeout
	
		tween = get_tree().create_tween()
		tween.tween_property(self, "modulate", Color.TRANSPARENT, 0.5)
	
		await get_tree().create_timer(0.6).timeout
		ended = true
		hide()
	else:
		hide()
	
	
	
	
	
	
