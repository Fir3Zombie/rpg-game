extends Node2D

func _ready():
		
	if global.player_spawn_position_set:
		$player.position = global.player_spawn_position
		global.player_spawn_position_set = false
		
	elif global.game_first_loadin:
		$player.position = Vector2(global.player_start_posx, global.player_start_posy)

func _process(_delta):
	change_scenes()
	

func  _on_village_exitpoint_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		global.next_scene = "world"
		#where player appears in world
		global.player_spawn_position = Vector2(-431.0, -27.0)
		global.player_spawn_position_set = true
		
		global.transition_scene = true


func  _on_village_exitpoint_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		if global.next_scene == "world":
			global.transition_scene = false
			global.next_scene = ""
		
		global.transition_scene = true

func change_scenes():
	if global.transition_scene and global.next_scene == "world":
		global.game_first_loadin = false
		global.finish_changescenes()
		get_tree().change_scene_to_file("res://scenes/world.tscn")
