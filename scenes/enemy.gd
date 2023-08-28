extends RigidBody2D


func take_damage(instigator: Node2D):
	if is_instance_valid(instigator):
		apply_central_impulse(instigator.global_position.direction_to(global_position) * 300)
