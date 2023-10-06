extends Node

signal cheese_changed

var meh = 15

var cheese = 0:
	set(value):
		cheese = value
		cheese_changed.emit()


var last_checkpoint: Vector2
var camera: CameraWithShake

func _ready():
	load_game()

func save_game():
	var data = get_data()
	var data_string = JSON.stringify(data)
	var file = FileAccess.open("user://game.dat", FileAccess.WRITE)
#	var file = FileAccess.open_encrypted_with_pass("user://game.save", FileAccess.WRITE, "meh")
#	file.store_string(data_string)
	file.store_32(cheese)
	file.store_16(meh)
	file.store_float(last_checkpoint.x)
	file.store_float(last_checkpoint.y)
 
func load_game():
	var file = FileAccess.open("user://game.dat", FileAccess.READ)
#	var file = FileAccess.open_encrypted_with_pass("user://game.save", FileAccess.READ, "meh")
#	var data_string = file.get_as_text()
#	var data = JSON.parse_string(data_string)
#	set_data(data)
	cheese = file.get_32()
	meh = file.get_16()
	last_checkpoint.x = file.get_float()
	last_checkpoint.y = file.get_float()


func get_data():
	return {
		"meh": meh,
		"cheese": cheese,
		"last_checkpoint_x": last_checkpoint.x,
		"last_checkpoint_y": last_checkpoint.y,
	}

func set_data(data):
	meh = data.meh
	cheese = data.cheese
	last_checkpoint = Vector2(data.last_checkpoint_x, data.last_checkpoint_y)


func _input(event):
	if event.is_action_pressed("test"):
		save_game()
	if event.is_action_pressed("test2"):
		load_game()


