extends StaticBody2D

export var speed = 10
export var dir = Vector2.ZERO
export var switch_dir_time = 5

onready var switch_dir_timer : Timer = $SwitchDirection

func _ready():
	switch_dir_timer.wait_time = switch_dir_time

func _physics_process(delta):
	position += dir.normalized() * delta * speed

func switch_dir():
	dir.y *= -1

func _on_Area2D_body_entered(body):
	if "Platform" in body.name:
		switch_dir()

func _on_SwitchDirection_timeout():
	switch_dir()
