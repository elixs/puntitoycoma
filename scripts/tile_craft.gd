class_name TileCraft
extends TileMap


# {coord: Vector2i : {destructible: bool; health: int }}
var data: Dictionary


func _ready():
	var cells = get_used_cells(0)
	for coord in cells:
		var tile_data = get_cell_tile_data(0, coord)
		data[coord] = {
			"destructible": tile_data.get_custom_data("destructible"),
			"health": tile_data.get_custom_data("health")
		}

func get_health(coord: Vector2i) -> int:
	return data[coord].health

func set_health(coord: Vector2i, value: int) -> void:
	data[coord].health = value


func is_destructible(coord: Vector2i) -> bool:
	return data[coord].destructible
