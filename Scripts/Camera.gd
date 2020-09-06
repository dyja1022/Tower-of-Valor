extends Camera2D

onready var players = get_tree().get_nodes_in_group("player")
var highest_pos_y = 400
var game_over = false

func _process(delta):
	players = get_tree().get_nodes_in_group("player")
	if game_over:
		return
	
	FollowHighestPlayer()

func FollowHighestPlayer():
	var highest_pos = Vector2(0, 500)
	for p in players:
		if p.position.y < highest_pos.y:
			highest_pos = p.position
			
	position.y = lerp(position.y, highest_pos.y, get_process_delta_time()) 
	
func StayOnHighest():
	for p in players:
		if p.position.y + 10 < highest_pos_y:
			highest_pos_y = p.position.y + 10
	position.y = lerp(position.y, highest_pos_y, get_process_delta_time()) 

func _on_Main_game_over():
	game_over = true
