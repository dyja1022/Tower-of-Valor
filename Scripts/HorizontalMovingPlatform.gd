extends KinematicBody2D

export var speed = 10
export var dir = Vector2.ZERO

func _physics_process(delta):
	position += dir.normalized() * delta * speed
	
func _on_Area2D_body_entered(body):
	if "Platform" in body.name:
		dir.x *= -1
