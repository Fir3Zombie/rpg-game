extends Node2D

@onready var cliffside_sign = $cliffside_sign2/Control/Label
@onready var cliff_path_sign = $cliff_path_sign2/Control/Label
@onready var sign_interact = $sign_interact/Control/Label
var in_cliffside_sign_area = false
var in_cliff_path_sign_area = false


func _ready():
	
	sign_interact.hide()
	cliffside_sign.hide()
	cliff_path_sign.hide()
	in_cliffside_sign_area = false
	in_cliff_path_sign_area = false

	
	
	
		
	if global.player_spawn_position_set:
		$player.position = global.player_spawn_position
		global.player_spawn_position_set = false
		
	elif global.game_first_loadin:
		$player.position = Vector2(global.player_start_posx, global.player_start_posy)
		
func _process(_delta):

	
	if in_cliffside_sign_area and Input.is_action_just_pressed("interact"):
		cliffside_sign.show()
		print("show cliffside")
		await get_tree().create_timer(1.5).timeout
		cliffside_sign.hide()
		print("hide cliff path")
	
	if in_cliff_path_sign_area and Input.is_action_just_pressed("interact"):
		cliff_path_sign.show()
		print("show cliff path")
		await get_tree().create_timer(1.5).timeout
		cliff_path_sign.hide()
		print("hide cliff path")
	change_scenes()
	
	
func _on_cliffside_sign_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		in_cliffside_sign_area = true
		sign_interact.show()



func _on_cliffside_sign_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		in_cliffside_sign_area = false
		sign_interact.hide()


func _on_cliff_path_sign_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		in_cliff_path_sign_area = true
		sign_interact.show()


func _on_cliff_path_sign_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		in_cliff_path_sign_area = false
		sign_interact.hide()


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

func _on_cliff_path_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		global.next_scene = "cliff_path"
		
		global.player_spawn_position = Vector2(-598.0,-79.0)
		global.player_spawn_position_set = true
		
		global.transition_scene = true


func _on_cliff_path_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
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
		
	elif global.next_scene == "cliff_path":
		global.finish_changescenes()
		get_tree().change_scene_to_file("res://scenes/cliff_path.tscn")
		

	
