extends CharacterBody2D

@export var speed = 100
@export var jump_speed = 200
var acceleration = 1000
var gravity = 600
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")

func _ready() -> void:
	animation_tree.active = true


func _physics_process(delta: float) -> void:
	var move_input = Input.get_axis("move_left", "move_right")
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if is_on_floor and Input.is_action_just_pressed("jump"):
		velocity.y = -jump_speed
	
	velocity.x = move_toward(velocity.x, speed * move_input, acceleration * delta)
	
	move_and_slide()
	
	# animation
	if abs(velocity.x) > 10:
		playback.travel("run")
	else:
		playback.travel("idle")
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("test"):
		animation_player.play("jump")
