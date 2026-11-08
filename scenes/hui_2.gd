extends Node2D


# Called when the node enters the scene tree for the first time.




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	play_anim()

func play_anim():
	var anim = $healthbar
	var health = global.player_health 
	
	
	
	if health >= 11:
		anim.play("health6")
		
	elif health >= 9:
		anim.play("health5")
		
	elif health >= 7:
		anim.play("health4")
		
	elif health >= 5:
		anim.play("health3")
		
	elif health >= 3:
		anim.play("health2")
		
	elif health >= 1:
		anim.play("health1")
	
	else:
		anim.play("death_health")
		
	
	
	
