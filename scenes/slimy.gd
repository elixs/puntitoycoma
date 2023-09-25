extends CharacterBody2D

var speed = 50
var acceleration = 500
var gravity = 400

var direction = Vector2.RIGHT

@onready var pivot = $Pivot
@onready var floor_ray_cast = $Pivot/FloorRayCast
@onready var hit_box = $HitBox

func _ready():
	hit_box.body_entered.connect(_on_body_entered)

func _physics_process(delta):
	velocity.x = move_toward(velocity.x, pivot.scale.x * speed, acceleration * delta)
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if is_on_floor() and not floor_ray_cast.is_colliding():
		pivot.scale.x *= -1
	
	move_and_slide()


func _on_body_entered(body: Node):
	if body.has_method("take_damage"):
		body.take_damage()
