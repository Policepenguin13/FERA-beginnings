extends Area2D

@export var waypoints: Array[Node2D]

var from

signal PlusOneFlower

func _ready():
	hide()

func Ready():
	# RunAway(self)
	show()
	self.body_entered.connect(BodyEnter)
	self.body_exited.connect(BodyExit)
	var target = waypoints.pick_random()
	# print(str(self.name) + "'s target is " + str(target.name))
	var offsetX = randf_range(-56.0, 56.0)
	var offsetY = randf_range(-56.0, 56.0)
	# print(str(self.name) + " offset X is " + str(offsetX))
	# print(str(self.name) + " offset Y is " + str(offsetY))
	self.position.x = target.position.x + offsetX
	self.position.y = target.position.y + offsetY

func _process(_delta):
	if self.has_overlapping_areas() or self.has_overlapping_bodies():
		# print(self.name + " found overlapping bodies, running away!!")
		if has_overlapping_areas():
			from = get_overlapping_areas().pick_random()
		elif has_overlapping_bodies():
			from = get_overlapping_bodies().pick_random()
		RunAway()

func RunAway():
	# print(str(waypoints))
	# print(str(from))
	var target
	# print(str(self.name) + "'s target is " + str(target.name))
	var offsetX = randf_range(-56.0, 56.0)
	var offsetY = randf_range(-56.0, 56.0)
	if randi_range(0,100) >= 50:
		target = waypoints.pick_random()
	# print(str(self.name) + "'s target is " + str(target.name))
	else:
		target = from
		var temp = randi_range(1,4)
		# print(self.name + "'s temp = " + str(temp))
		if temp == 1:
			offsetX = 30
			offsetY = 30
		elif temp == 2:
			offsetX = -30
			offsetY = 30
		elif temp == 3:
			offsetX = 30
			offsetY = -30
		else:
			offsetX = -30
			offsetY = -30
	# print(str(self.name) + " offset X is " + str(offsetX))
	# print(str(self.name) + " offset Y is " + str(offsetY))
	self.position.x = target.position.x + offsetX
	self.position.y = target.position.y + offsetY
	
	if from != null:
		if from.is_in_group("flower"):
			# print(str(self.name)+" ran away from another flower ("+str(from.name)+")")
			pass
		if from == $"../../TileMapLayer":
			# print(str(self.name)+ " ran away from the tile map")
			pass
		if from == $"../../Gatherer":
			PlusOneFlower.emit()
			self.get_child(1).set_deferred("disabled", true)
			self.get_child(2).start()
			await self.get_child(2).timeout
			self.get_child(1).set_deferred("disabled", false)
		else:
			# print(str(self.name)+" ran away from something that wasn't a flower or the tilemap, " + str(from.name))
			pass


func BodyEnter(body):
	# print(str(self.name)+"'s body was entered by " + str(body.name))
	from = body
	# RunAway()

func BodyExit(_body):
	from = null
