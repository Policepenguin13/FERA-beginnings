extends Node

var json = JSON.new()
var path = "res://Saves/data.json"
#var EmptySave = {
#		"SaveNumber" : # 1 2 or 3
#		"Milestone" : StoryMilestone
#		"PName" : PlayerName
#		"FName" : FeraName
#		"BagO" : BagOrder
#		"BagA" : BagAmounts
#		"Money" : funds
#		"TDanced" : ThreeDanced
#		"THappened" : ThreeNameHappened
#		"FGoals" : FourGoals
#		"PlayerX" : # player x position
#		"PlayerY" : # player y position
#	}

var data = {}

func SAVE(content):
	var File = FileAccess.open(path,FileAccess.WRITE)
	File.store_string(json.stringify(content))
	File.close()
	
	File = null

func read_save():
	var file = FileAccess.open(path, FileAccess.READ)
	var content = json.parse_string(file.get_as_text())
	return content

func new_savefile():
	var file = FileAccess.open("res://Saves/EmptySavefile.json", FileAccess.READ)
	var content = json.parse_string(file.get_as_text())
	data = content
	SAVE(content)

func _ready():
	pass
