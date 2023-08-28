extends MarginContainer

@onready var cheese_label: Label = $HBoxContainer/Cheese


func _ready() -> void:
	Game.cheese_changed.connect(_update_cheese)
	_update_cheese()


func _update_cheese():
	cheese_label.text = str(Game.cheese)
