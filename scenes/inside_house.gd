extends Node2D

var player_in_area = false
var player_speak_area = false
@onready var interact_screen = $action_label/Control/Label
@onready var speak_to_nurse = $speak_to_nurse/Control/Label
@onready var nurse_speaking = $nurse_speaking/Control/Label
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interact_screen.hide()
	speak_to_nurse.hide()
	nurse_speaking.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if player_in_area and Input.is_action_just_pressed("interact"):
		print("input qualified")
		global.next_scene = "village"
		global.player_spawn_position = Vector2(25.0,-86.0)
		global.player_spawn_position_set = true
		global.transition_scene = true
		
	change_scenes()
	if player_speak_area and Input.is_action_just_pressed("interact"):
		nurse_speaking.show()
		print("speaking to nurse started")

		if player_speak_area and Input.is_action_just_pressed("interact"):
			await get_tree().create_timer(2).timeout 
			nurse_speaking.hide()
			print("stopped speaking to nurse")
			
		

func _on_nurse_speak_body_entered(_body: Node2D) -> void:
	speak_to_nurse.show()
	player_speak_area = true
	print("player entered nurse radius")


func _on_nurse_speak_body_exited(_body: Node2D) -> void:
	speak_to_nurse.hide()
	player_speak_area = false
	print("player exited nurse radius")


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
