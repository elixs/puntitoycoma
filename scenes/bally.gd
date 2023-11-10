class_name Bally
extends CharacterBody2D

var max_speed = 150
var jump_speed = 150
var acceleration = 1000
var gravity = 400
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")
@onready var pivot: Node2D = $Pivot
@onready var cheese_spawn = $Cannon/CheeseSpawn
@onready var a: Sprite2D = $Cannon/A
@onready var health_bar = $CanvasLayer/GUI/HealthBar
@onready var cannon = $Cannon

var max_health = 100
var health = 100:
	set(value):
		health = clamp(value, 0, max_health)
		if(health_bar):
			var tween = create_tween()
			tween.tween_property(health_bar, "value", health, 0.2)
#			health_bar.value = health
		if health == 0:
			kill()
		

@export var cheese_scene: PackedScene
@onready var cheese_counter: MarginContainer = $CanvasLayer/CheeseCounter


func _ready() -> void:
	animation_tree.active = true
	Game.last_checkpoint = global_position


func _process(delta):
	cannon.rotation = (get_global_mouse_position() - cannon.global_position).angle()


func _physics_process(delta: float) -> void:
	var move_input = Input.get_axis("move_left", "move_right")
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = -jump_speed
		Debug.dprint("jump")
	
	velocity.x = move_toward(velocity.x, max_speed * move_input, acceleration * delta)
	
	move_and_slide()
	
	if Input.is_action_just_pressed("cheese"):
		fire()
	
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

func fire():
	if not cheese_scene:
		return
	_update_direction()
	var cheese = cheese_scene.instantiate()
	get_parent().add_child(cheese)
	cheese.global_position = cheese_spawn.global_position
	cheese.rotation = cheese_spawn.global_position.direction_to(get_global_mouse_position()).angle()
	Game.cheese += 1
	var tween = create_tween()
	tween.tween_property(a, "position:x", -20, 0.1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	tween.tween_property(a, "position:x", 0, 0.2)

func kill():
	global_position = Game.last_checkpoint
	health = max_health

func take_damage():
	health -= 10
	if Game.camera:
		Game.camera.shake()

func _update_direction():
	var new_direction = sign(get_global_mouse_position().x - global_position.x)
	if new_direction:
		pivot.scale.x = new_direction
