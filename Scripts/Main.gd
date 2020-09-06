extends Node2D

signal game_over

export var is_game_over = false
onready var players = get_tree().get_nodes_in_group("player")
export (PackedScene) var spear
	

func _on_Player_zero_health():
	var all_dead = true
	
	for p in players:
		if p.health > 0:
			all_dead = false
	
	if all_dead:
		is_game_over = true
	
	emit_signal("game_over")
