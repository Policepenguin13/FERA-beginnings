extends Control

func _ready():
	$DialogueBox.hide()
	$DialogueBox/saying.visible_characters = -1
	$DialogueBox/saying.text = "nobody should be reading this"
	
func _process(_delta):
	%saying.visible_characters = -1
