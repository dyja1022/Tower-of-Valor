extends Camera2D

onready var players = get_tree().get_nodes_in_group("player")
var highest_pos_y = 400
var game_over = false

func _process(delta):

	if game_over:
		return
		
	for p in players:
		if p.position.y + 10 < highest_pos_y:
			highest_pos_y = p.position.y + 10
	
	position.y = lerp(position.y, highest_pos_y, delta) 


func _on_Main_game_over():
	game_over = true
