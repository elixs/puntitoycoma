class_name TileCraft
extends TileMap


# {coord: Vector2i : {destructible: bool; health: int }}
var data: Dictionary


var timer: Timer


func _ready():
	var cells = get_used_cells(0)
	for coord in cells:
		var tile_data = get_cell_tile_data(0, coord)
		data[coord] = {
			"destructible": tile_data.get_custom_data("destructible"),
			"health": tile_data.get_custom_data("health")
		}
	timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = 1
	add_child(timer)
	timer.timeout.connect(_on_timer_timeout)

func get_health(coord: Vector2i) -> int:
	return data[coord].health

func set_health(coord: Vector2i, value: int) -> void:
	data[coord].health = value


func is_destructible(coord: Vector2i) -> bool:
	if coord in data:
		return data[coord].destructible
	return false


func _input(event):
	if event.is_action_pressed("mine"):
		timer.start()
	if event.is_action_released("mine"):
		timer.stop()


func _on_timer_timeout():
	var coords = local_to_map(get_local_mouse_position())
	set_cell(0, coords, -1)
