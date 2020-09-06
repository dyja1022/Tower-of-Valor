extends StaticBody2D

export var speed = 10
export var dir = Vector2.ZERO
export var time_to_switch = 5.0

onready var switch_dir_timer : Timer = $SwitchDirection

func _ready():
	switch_dir_timer.wait_time = time_to_switch

func _physics_process(delta):
	position += dir.normalized() * delta * speed

func switch_dir():
	dir.y *= -1
	switch_dir_timer.start();
	
func _on_Area2D_body_entered(body):
	if "Platform" in body.name:
		switch_dir()

func _on_SwitchDirection_timeout():
	switch_dir()
