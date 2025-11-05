extends Area2D
# shortcuts for doing stuff

@export var SkipTo: int = 0
@export var ItemNeeded = false
@export var Item: String = ""
func _ready():
# 	return
	self.monitoring = false
	self.monitorable = false
	hide()

func Interact():
	# print("skip to number")
	Globals.StoryMilestone = SkipTo
	Globals.talking = false
	Globals.CanMove = true
	%inventory.InventoryOrder.clear()
	%inventory.InventoryAmount.clear()
	%inventory.UpdateUI()
	if ItemNeeded:
		%inventory.AddItem(Item)
