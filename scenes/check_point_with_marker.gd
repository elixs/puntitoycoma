extends Area2D

@onready var label = $Label
@export var marker: Marker2D

func _ready():
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node):
#	var bally = body as Bally
	if !marker:
		return
	Game.last_checkpoint = marker.global_position
	var tween = create_tween()
	tween.tween_property(label, "scale", Vector2.ONE * 5, 0.3).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(label, "modulate", Color.BLUE, 0.3).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(label, "scale", Vector2.ONE, 0.5).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
