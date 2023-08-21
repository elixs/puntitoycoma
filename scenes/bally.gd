extends CharacterBody2D

@export var speed = 200
@export var jump_speed = 200
var acceleration = 1000
var gravity = 400
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")
@onready var pivot: Node2D = $Pivot

func _ready() -> void:
	animation_tree.active = true


func _physics_process(delta: float) -> void:
	var move_input = Input.get_axis("move_left", "move_right")
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if is_on_floor and Input.is_action_just_pressed("jump"):
		velocity.y = -jump_speed
		Debug.dprint("jump")
	
	velocity.x = move_toward(velocity.x, speed * move_input, acceleration * delta)
	
	move_and_slide()
	
	# animation
	
	if velocity.x != 0:
		pivot.scale.x = sign(velocity.x)

	
	if is_on_floor():
		if abs(velocity.x) > 10 or move_input:
			playback.travel("run")
		else:
			playback.travel("idle")
	else:
		if velocity.y < 0:
			playback.travel("jump")
		else:
			playback.travel("fall")
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("test"):
		print("test")
