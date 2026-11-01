extends Node2D

func _ready():
		
	if global.player_spawn_position_set:
		$player.position = global.player_spawn_position
		global.player_spawn_position_set = false
		
	elif global.game_first_loadin:
		$player.position = Vector2(global.player_start_posx, global.player_start_posy)
		
func _process(_delta):
	change_scenes()

# world to cliffside
func _on_cliffside_transition_point_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		global.next_scene = "cliffside"
		# spawn position inside the cliffside scene
		global.player_spawn_position = Vector2(-33.0,128.0)
		global.player_spawn_position_set = true
		
		global.transition_scene = true
		

func _on_cliffside_transition_point_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		if global.next_scene == "cliffside":
			global.transition_scene = false
			global.next_scene = ""
			




#world to village
func _on_village_transition_point_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		global.next_scene = "village"
		
		#spawn position inside the village/beginning
		global.player_spawn_position = Vector2(862.0,30.0)
		global.player_spawn_position_set = true
		
		global.transition_scene = true

			

func _on_village_transition_point_body_exited(body: Node2D) -> void:

	if body.has_method("player"):
		if global.next_scene == "village":
			global.transition_scene = false
			global.next_scene = ""


func change_scenes():
	if not global.transition_scene:
		return
		
	if global.next_scene == "village":
		global.finish_changescenes()
		get_tree().change_scene_to_file("res://scenes/beginning.tscn")
		
	elif global.next_scene == "cliffside":
		global.finish_changescenes()
		get_tree().change_scene_to_file("res://scenes/cliffside.tscn")
