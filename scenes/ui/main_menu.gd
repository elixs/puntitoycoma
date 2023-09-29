extends MarginContainer

@onready var start: Button = %Start
@onready var exit: Button = %Exit

func _ready() -> void:
	start.pressed.connect(_on_start_pressed)
	exit.pressed.connect(_on_exit_pressed)


func _on_start_pressed():
	LevelManager.start_game()


func _on_exit_pressed():
	get_tree().quit()
