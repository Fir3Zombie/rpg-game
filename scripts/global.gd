extends Node

var player_health = 12
var player_current_attack = false

var current_scene = "village"
var next_scene = ""
var transition_scene = false

var game_first_loadin = true


#spawn position
var player_spawn_position_set = false
var player_spawn_position = Vector2.ZERO

var player_start_posx = -1040.0
var player_start_posy = 71.0

var player_exit_village_posx = -424.0
var player_exit_village_posy = -25.0

var player_exit_cliffside_posx = 109.0
var player_exit_cliffside_posy = -132.0

func finish_changescenes():
	if next_scene != "":
		current_scene = next_scene
		next_scene = ""
		transition_scene = false
