extends KinematicBody2D

onready var players = get_tree().get_nodes_in_group("player")
export (PackedScene) var SPEAR
onready var spear_pos = $SpearPos.position

var spear 
var has_spear = false

func _ready():
	yield(get_tree().create_timer(2.0), "timeout")
	reload_spear()

func _process(delta):
	players = get_tree().get_nodes_in_group("player")
	if has_spear:
		yield(get_tree().create_timer(2.0), "timeout")
		throw_spear()
	
func reload_spear():
	var s = SPEAR.instance()
	s.position = spear_pos
	has_spear = true
	spear = s
	add_child(s)
	print(spear.global_position)

func throw_spear():
	if has_spear:
		if players.size() > 0:
			players.shuffle()
			spear.set_target(players[0].global_position)
			has_spear = false
			


func _on_ReloadSpear_timeout():
	if !has_spear:
		reload_spear()
