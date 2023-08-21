extends Node


@onready var canvas_layer  = CanvasLayer.new()
@onready var container = VBoxContainer.new()


func _ready() -> void:
	add_child(canvas_layer)
	canvas_layer.layer = 100
	canvas_layer.add_child(container)
	container.set("theme_override_constants/separation", 0)


func dprint(message: Variant, seconds: int = 2) -> void:
	print(message)
	var label = Label.new()
	label.text = str(message)
	label.set("theme_override_constants/outline_size", 2)
	label.set("theme_override_colors/font_outline_color", Color.BLACK)
	container.add_child(label)
	container.move_child(label, 0)
	await get_tree().create_timer(seconds).timeout
	container.remove_child(label)
	label.queue_free()
