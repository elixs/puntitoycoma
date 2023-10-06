class_name CameraWithShake
extends Camera2D

@export var intensity: float = 10

func _ready():
	Game.camera = self
	


func shake():
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BACK)

	tween.tween_property(self, "offset", get_rand_vector(), 0.05)
	tween.tween_property(self, "offset", get_rand_vector(), 0.05)
	tween.tween_property(self, "offset", get_rand_vector(), 0.05)
	tween.tween_property(self, "offset", get_rand_vector(), 0.05)
	tween.tween_property(self, "offset", get_rand_vector(), 0.05)
	tween.tween_property(self, "offset", Vector2.ZERO, 0.05)



func get_rand_vector() -> Vector2:
	return Vector2(
		randf_range(-intensity, intensity),
		randf_range(-intensity, intensity)
	)
