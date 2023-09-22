extends Area2D

func _ready():
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node):
	if body.has_method("kill"):
		body.kill()
