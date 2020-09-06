extends KinematicBody2D

onready var players = get_tree().get_nodes_in_group("player")
export (PackedScene) var SPEAR
onready var spear_pos = $SpearPos.position
export var start_attack_delay = 3.0

onready var reload_time = $ReloadSpear

var spear 
var has_spear = false

func _ready():
	yield(get_tree().create_timer(start_attack_delay), "timeout")
	reload_spear()

func _process(delta):
	if has_spear:
		yield(get_tree().create_timer(2.0), "timeout")
		throw_spear()
	
func reload_spear():
	var s = SPEAR.instance()
	s.position = spear_pos
	add_child(s)
	spear = s
	reload_time.start()
	has_spear = true

func throw_spear():
	if spear == null:
		reload_spear()
		return
	if has_spear:
		if players.size() > 0:
			players.shuffle()
			if players[0] != null:
				spear.set_target(players[0].global_position)
				has_spear = false


func _on_ReloadSpear_timeout():
	if !has_spear:
		reload_spear()
