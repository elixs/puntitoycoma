extends Node

signal cheese_changed

var cheese = 0:
	set(value):
		cheese = value
		cheese_changed.emit()


var last_checkpoint: Vector2
