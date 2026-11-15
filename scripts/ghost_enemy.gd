extends CharacterBody2D

var speed = 45
var player_chase = false
var player = null

var health = 100
var player_inattack_zone = false
var can_take_damage = true
var ghost_alive = true



func _physics_process(_delta: float) -> void:
	
	if health <= 0 and ghost_alive:
		ghost_alive = false
		health = 0 
		speed = 0
		player_chase = false
		player_inattack_zone = false
		
		velocity = Vector2.ZERO
		$AnimatedSprite2D.play("death")
		print("ghost dead :(")
		return
		
	deal_with_damage()
	update_health()
	
	if player_chase and is_instance_valid(player):
		var distance = global_position.distance_to(player.global_position)
		
		if distance > 10:
			var direction = global_position.direction_to(player.global_position)
			velocity = direction * speed
			$AnimatedSprite2D.play("walk")
		else:
			velocity = Vector2.ZERO
			$AnimatedSprite2D.play("idle")
			
			
		move_and_slide()
	
		if player.global_position.x < global_position.x:
			$AnimatedSprite2D.flip_h = false
		else:
			$AnimatedSprite2D.flip_h = true
		
		
		

		


func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player = body
		player_chase = true
		print("player detected")


func _on_detection_area_body_exited(body: Node2D) -> void:
	if body == player:
		player = null
		player_chase = false
		print("player left detection area")
		
func enemy():
	pass
	
#creates a functional hitbox 



func _on_ghotst_hitbox_body_entered(body: Node2D) -> void:
	if ghost_alive and body.has_method("player"):
		player_inattack_zone = true
		print("player etered ghost hitbox")


func _on_ghotst_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_inattack_zone = false
		print("player exited ghost hitbox")
		
#damage system
func deal_with_damage():
	if ghost_alive and player_inattack_zone and global.player_current_attack == true:
		if can_take_damage == true:
			health -= 15
			$take_damage_cooldown.start()
			can_take_damage = false
			print("ghost health = ", health)
			
			
			
func _on_take_damage_cooldown_timeout() -> void:
	can_take_damage = true
	
func update_health():
	
	var healthbar = $health_bar
	healthbar.value = health
	
	if health >= 100:
		healthbar.hide()
	else:
		healthbar.show()





func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "death":
		self.queue_free()
