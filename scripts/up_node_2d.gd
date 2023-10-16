class_name UpNode2D
extends Node2D

func _process(delta):
	var positive_rotation =  fmod((fmod(global_rotation, 2 * PI) + 2 * PI), 2 * PI)
	var flip = positive_rotation > PI / 2 and positive_rotation < 3 * PI / 2
	global_scale.x = -1 if flip else 1
