extends CharacterBody2D

var speed = 45
var player_chase = false
var player = null

var health = 100
var player_inattack_zone = false
var can_take_damage = true
var slime_alive = true


func _physics_process(_delta):

	if health <= 0 and slime_alive:
		slime_alive = false
		health = 0 
		speed = 0
		player_chase = false
		player_inattack_zone = false
		
		velocity = Vector2.ZERO
		$AnimatedSprite2D.play("death")
		print("slime died")
		return
		
	if not slime_alive:
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
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false

		
		
		
		
		
func _on_detection_area_body_entered(body): 
	if body.has_method("player"):
		player = body
		player_chase = true
		print("player detected")
	

func _on_detection_area_body_exited(body):
	
	if body == player:
		player = null
		player_chase = false
		print("player left detection area")
	
func enemy():
	pass

#creates a functional hitbox (entered/exit)
func _on_enemy_hitbox_body_entered(body):
	if slime_alive and body.has_method("player"):
		player_inattack_zone = true
		print("player entered slime hitbox")


func _on_enemy_hitbox_body_exited(body):
	if body.has_method("player"):
		player_inattack_zone = false
		print("player exited slime hitbox")


# take damage proccesor (slime has 100hp unlike the player)
func deal_with_damage():
	if slime_alive and player_inattack_zone and global.player_current_attack == true:
		if can_take_damage == true:
			health -= 20
			$take_damage_cooldown.start()
			can_take_damage = false
			print(health)
			


# hit cooldown (prevents player from spamming attack)
func _on_take_damage_cooldown_timeout():
	can_take_damage = true

func update_health():
	
	var healthbar = $healthbar
	
	healthbar.value = health 
	
	if health >= 100:
		healthbar.visible = false
	else:
		healthbar.visible = true


func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "death":
		self.queue_free()
