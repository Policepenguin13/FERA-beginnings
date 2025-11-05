extends HSlider

@export var bus_name: String
var bus_index: int

func _ready():
	bus_index = AudioServer.get_bus_index(bus_name)
	if bus_name == "Background":
		Globals.BgVol = AudioServer.get_bus_volume_linear(bus_index)
		max_value = Globals.BgVol+1.0
		value = Globals.BgVol
	elif bus_name == "Master":
		Globals.MasterVol = AudioServer.get_bus_volume_linear(bus_index)
		max_value = Globals.MasterVol+1.0
		value = Globals.MasterVol
	# print(name + " value: " + str(value))
	# print(name + " max value: " + str(max_value))
	
	
	value_changed.connect(_on_value_changed)
	# AudioServer.set_bus_volume_db(bus_index, 0.0)
	# value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))
	# value = max_value

func _on_value_changed(val: float):
# 	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus_name), linear_to_db(val))
	# print(name + " value: " + str(val))
	if bus_name == "Background":
		Globals.BgVol = val
	elif bus_name == "Master":
		Globals.MasterVol = val
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus_name), linear_to_db(val))
	# AudioServer.set_bus_volume_db(bus_index, linear_to_db(val))
	# print(name + "'s bus volume: " + str(AudioServer.get_bus_volume_db(bus_index)))
	
# func _process(_delta):
# 	print(name.to_upper() +" "+ str(AudioServer.get_bus_index(bus_name)))
# 	print(name.to_upper() +" "+ str(linear_to_db(value)))
# 	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus_name), linear_to_db(value))
