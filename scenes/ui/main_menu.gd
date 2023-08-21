extends MarginContainer

@onready var start: Button = %Start
@onready var exit: Button = %Exit

#var main = preload("res://scenes/main.tscn")
@export var main: PackedScene

func _ready() -> void:
	start.pressed.connect(_on_start_pressed)
	exit.pressed.connect(_on_exit_pressed)


func _on_start_pressed():
	if main:
		get_tree().change_scene_to_packed(main)


func _on_exit_pressed():
	get_tree().quit()
