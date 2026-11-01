extends Sprite2D



var health = global.player_health 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	play_anim()

func play_anim():
	var anim = $healthbar
	
	if health == 11 or 12:
		anim.play("health6")
		
	elif health == 9 or 10:
		anim.play("health5")
		
	elif health == 7 or 8:
		anim.play("health4")
		
	elif health == 5 or 6:
		anim.play("health3")
		
	elif health == 3 or 4:
		anim.play("health2")
		
	elif health == 1 or 2:
		anim.play("health1")
	
	else:
		health = 0
		anim.play("death_health")
	
	
	
