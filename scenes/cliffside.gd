extends Node2D

func _ready():
	if global.player_spawn_position_set:
		$player.position = global.player_spawn_position
		global.player_spawn_position_set = false
		
	elif global.game_first_loadin:
		$player.position = Vector2(global.player_start_posx, global.player_start_posy)
		
		

func _process(_delta):
	change_scenes()
	

# cliffside to world
func _on_ciffside_exitpoint_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		global.next_scene = "world"
		
		# spawn position inside the world
		global.player_spawn_position = Vector2(112.0,-133.0)
		global.player_spawn_position_set = true
		
		
		global.transition_scene = true


func _on_ciffside_exitpoint_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		if global.next_scene == "world":
			global.transition_scene = false
			global.next_scene = ""
			
func change_scenes():
	if global.transition_scene and global.next_scene == "world":
		global.finish_changescenes()
		get_tree().change_scene_to_file("res://scenes/world.tscn")
