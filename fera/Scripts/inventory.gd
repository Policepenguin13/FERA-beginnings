extends PanelContainer
# controls the inventory list

var Slots = []
@export var InventoryOrder: Array[String] = []
var InventoryAmount: Dictionary[String, int] = {}
# var showList: Array[String] = []

func _ready():
	Slots = $ScrollContainer/container1.get_children()
	# print(str(Slots))
	InventoryOrder.clear()
	InventoryAmount.clear()
	UpdateUI()
	# Test()

func Test():
	await get_tree().create_timer(2).timeout
	AddItem("Sausage Roll")
	AddItem("Flower")
	await get_tree().create_timer(1).timeout
	AddItem("Sausage Roll")
	
	# TestTwo()

func TestTwo():
	await get_tree().create_timer(2).timeout
	RemoveItem("Sausage Roll")
	RemoveItem("Flower")
	# RemoveItem("Capture Crystal")

func AddItem(Item: String):
	if InventoryOrder.has(Item):
		# print("order already has item (" + Item + ")")
		var itemQuantity = 0
		itemQuantity = InventoryAmount.get(Item)
		# print("item quantity = " + str(itemQuantity))
		itemQuantity += 1
		InventoryAmount.set(Item, itemQuantity)
	else:
		# print("order does not have item (" + Item + ") until now!")
		InventoryOrder.append(Item)
		InventoryAmount.get_or_add(Item, +1)
		# print("AMOUNT: " + str(InventoryAmount))
	# print("-ADD ITEM DONE-")
	
	UpdateUI()

func RemoveItem(Item: String):
	if InventoryOrder.has(Item):
		# print("item (" + Item + ") is in ur inventory")
		var itemQuantity = 0
		itemQuantity = InventoryAmount.get(Item)
		# print("item quantity = " + str(itemQuantity))
		itemQuantity -= 1
		if itemQuantity <= 0:
			# print("item quantity is <= 0, removing it")
			InventoryAmount.erase(Item)
			InventoryOrder.erase(Item)
			# print("ORDER: " + str(InventoryOrder))
			# print("AMOUNT: " + str(InventoryAmount))
		else:
			# print("itemQuantity ("+ str(itemQuantity) + ") is <= 0 ")
			InventoryAmount.set(Item, itemQuantity)
	else:
		print("can't remove an item you don't have!")
		pass
	# print("~REMOVE ITEM DONE~")
	UpdateUI()

func UpdateUI():
	Globals.BagAmounts = InventoryAmount
	Globals.BagOrder = InventoryOrder
	if InventoryOrder.size() != 0:
		# print("there is something in ur inventory")
		var number = 0
		for thing in Slots: #setup
			Slots[number].text = "adding"
			Slots[number].set_self_modulate(Color(1,1,1,1))

		for bob in InventoryOrder: #fills the slots
			var q = InventoryAmount.get(bob)
			if q <= 999:
				Slots[number].text = str(q)+"x " + bob
			else:
				Slots[number].text = "999+x " + bob
			Slots[number].set_self_modulate(Color(1,1,1,1))
			number +=1
		
		for all in Slots: #deals with the rest
			if all.text == "adding":
				all.text =  "empty slot"
				all.set_self_modulate(Color(1,1,1,0.5))
				
	else:
		# print("inventory is empty")
		for thing in Slots:
			# print(str(thing))
			thing.set_self_modulate(Color(1,1,1,0.5))
			thing.text = "empty slot"
	
	if Globals.funds <= 999:
		$money.text = "$" + str(Globals.funds)
	else:
		$money.text = "$999+"
