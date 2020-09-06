extends "res://Scripts/Enemy.gd"

onready var attack_area = $SpearArea

export var health = 3
export var damage = 2
export var speed = 65

export var can_take_dmg = true
onready var invulnerable_timer = $Invulnerable

var velocity = Vector2.ZERO
export var dir = -1

func flip():
	scale.x *= -1

func switch_dir():
	dir *= -1
	flip()
	
func _ready():
	_health = health
	_damage = damage
	_speed = speed
	
func _physics_process(delta):
	velocity = Vector2.ZERO
	
	if is_on_wall():
		switch_dir()
	velocity.x = dir
	
	velocity = velocity.normalized() * _speed
	velocity = move_and_slide(velocity)
	
	for i in attack_area.get_overlapping_bodies():
		if i.is_in_group("player"):
			var push_dir = Vector2(i.position.x - position.x, 0).normalized()
			i.take_damage(_damage, push_dir, _damage * 100)
