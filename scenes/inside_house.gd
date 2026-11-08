extends Node2D

var player_in_area = false
@onready var interact_screen = $action_label/Control/Label
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interact_screen.hide()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if player_in_area and Input.is_action_just_pressed("interact"):
		print("input qualified")
		global.next_scene = "village"
		global.player_spawn_position = Vector2(25.0,-86.0)
		global.player_spawn_position_set = true
		global.transition_scene = true
	change_scenes()



#func _on_exit_entered_body_entered(body: Node2D) -> void:
func _on_exit_entered_body_entered(_body: Node2D) -> void:
	interact_screen.show()
	player_in_area = true
	print("player entered")
	print("entered - ", interact_screen.visible)



func _on_exit_entered_body_exited(_body: Node2D) -> void:
	interact_screen.hide()
	player_in_area = false
	print("player exited")
	print("exited - ", interact_screen.visible)



func change_scenes():
	if global.transition_scene and global.next_scene == "village":
		global.finish_changescenes()
		get_tree().change_scene_to_file("res://scenes/beginning.tscn")
