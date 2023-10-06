extends Area2D


@export var speed = 300
@onready var tile_raycast = $TileRaycast

func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta


func _on_body_entered(body: Node2D):
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage(self)
	if tile_raycast.is_colliding():
		Debug.dprint("collision")
		var pos = tile_raycast.get_collision_point()
		pos += transform.x * 2
		var tile_craft = body as TileCraft
		if tile_craft:
			var coords = tile_craft.local_to_map(pos)
			if tile_craft.is_destructible(coords):
				var health = tile_craft.get_health(coords)
				var new_health = max(health - 1, 0)
				tile_craft.set_health(coords, new_health)
				if new_health == 0:
					tile_craft.set_cell(0, coords, -1)






	
