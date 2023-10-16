class_name UpSprite
extends Sprite2D


func _process(delta):
	var positive_rotation =  fmod((fmod(global_rotation, 2 * PI) + 2 * PI), 2 * PI)
	var flip = positive_rotation > PI / 2 and positive_rotation < 3 * PI / 2
	flip_h = flip
	flip_v = flip
