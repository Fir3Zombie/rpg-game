extends Node2D


var player_in_area  = false
@onready var interact_screen = $action_label/Control/Label
var can_interact = false

func _ready():
	
	can_interact = false
	player_in_area = false
	interact_screen.hide()
	
	
	if global.player_spawn_position_set:
		$player.position = global.player_spawn_position
		global.player_spawn_position_set = false
		
	elif global.game_first_loadin:
		$player.position = Vector2(global.player_start_posx, global.player_start_posy)

	await get_tree().create_timer(0.3).timeout 
	can_interact = true
	print(can_interact)
func _process(_delta):
	
	if can_interact and player_in_area and Input.is_action_just_pressed("interact"):
		print("input qualified")
		global.next_scene = "inside_house"
		global.player_spawn_position = Vector2(72.0,148.0)
		#global.player_position_set = true
		global.transition_scene = true
	change_scenes()
	





func  _on_village_exitpoint_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		global.next_scene = "world"
		#where player appears in world
		global.player_spawn_position = Vector2(-431.0, -27.0)
		global.player_spawn_position_set = true
		
		global.transition_scene = true


func _on_village_exitpoint_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		if global.next_scene == "world":
			global.transition_scene = false
			global.next_scene = ""
		
		global.transition_scene = true
		
		
func _on_enter_house_body_entered(_body: Node2D) -> void:
	if not can_interact:
		return
	
	interact_screen.show()
	player_in_area = true
	print("player entered")
	print("entered - ", interact_screen.visible)

func _on_enter_house_body_exited(_body: Node2D) -> void:
	interact_screen.hide()
	player_in_area = false
	print("player exited")
	print("exIted - ", interact_screen.visible)
	
	
func change_scenes():
	if global.transition_scene and global.next_scene == "world":
		global.game_first_loadin = false
		global.finish_changescenes()
		get_tree().change_scene_to_file("res://scenes/world.tscn")
		
	elif global.transition_scene and global.next_scene == "inside_house":
		global.game_first_loadin = false
		global.finish_changescenes()
		get_tree().change_scene_to_file("res://scenes/inside_house.tscn")
