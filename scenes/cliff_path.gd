extends Node2D
var player_in_sign_area = false
@onready var sign_label = $sign/Control/Label


func _ready():
	
	sign_label.hide()
		
	if global.player_spawn_position_set:
		$player.position = global.player_spawn_position
		global.player_spawn_position_set = false
		
	elif global.game_first_loadin:
		$player.position = Vector2(global.player_start_posx, global.player_start_posy)
		
func _process(_delta):
	
	if player_in_sign_area and Input.is_action_just_pressed("interact"):
		print("input qualified")
		sign_label.show()
		await get_tree().create_timer(3).timeout
		print("sign time ended")
		sign_label.hide()
	
	
	
	change_scenes()

# cliff_path to world
func _on_world_entrance_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		global.next_scene = "world"
		global.player_spawn_position = Vector2(524.0,77.0)
		global.player_spawn_position_set = true
		
		global.transition_scene = true

func _on_world_entrance_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		if global.next_scene == "world":
			global.transition_scene = false
			global.next_scene = ""

func change_scenes():
	if not global.transition_scene:
		return
		
	if global.next_scene == "world":
		global.finish_changescenes()
		get_tree().change_scene_to_file("res://scenes/world.tscn")
		
	elif global.next_scene == "harbour":
		global.finish_changescenes()
		get_tree().change_scene_to_file("res://scenes/cliffside.tscn")


func _on_sign_area_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_sign_area = true
		print("player in area")


func _on_sign_area_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_sign_area = false
		print("player out of area")
