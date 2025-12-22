extends CharacterBody2D
#Who's Rem
var DefSpeed = 20
var Speed = 20
var Aiming = false
var lookingRight = true
var BowCharge = 0
var ArrowObj = preload("res://Scenes/Arrow.tscn")

var Dashing = false
var DashTime = 0
var DashSpeed = 2

var maxHealth = 3
var PlayerHealth = 3
var Arrows = 3

var dead = false

func _physics_process(delta: float) -> void:
	if !dead:
		z_index = global_position.y-12
		if(!Input.is_mouse_button_pressed(MouseButton.MOUSE_BUTTON_LEFT)):
			if BowCharge >=25 && Arrows > 0:
				$shoot.play()
				Arrows-=1
				BowCharge = 0
				var Arrow = ArrowObj.instantiate()
				var MousePos = get_global_mouse_position()
				var Aim = (MousePos - global_position).angle()
				Arrow.rotation = Aim
				Arrow.global_position = global_position
				get_parent().add_child(Arrow)
			
		if BowCharge==0 and Input.is_action_just_pressed("shoot") && Arrows > 0:
			$BowPivot/AnimationPlayer.play("shootBow")
			$charge.play()
		if Input.is_action_just_released("shoot"):
			$BowPivot/AnimationPlayer.play("RESET")
			$BowPivot/Bow.frame = 0
		if(Input.is_mouse_button_pressed(MouseButton.MOUSE_BUTTON_LEFT) && Arrows > 0):
			BowCharge+=1
		else:
			$BowPivot/Bow.frame = 0
			BowCharge = 0
			
		if(BowCharge > 0):
			Speed = 5
		else:
			Speed = DefSpeed
			
		var InputDir = Input.get_vector("Left","Right", "Up", "Down")
		velocity += InputDir * Speed
		if(DashTime > 7 || Dashing == false):
			velocity*=0.9
		if Input.is_action_just_pressed("Right"):
			lookingRight = true
		if Input.is_action_just_pressed("Left"):
			lookingRight = false
		if !Dashing:
			if velocity.length() <= 30:
				if lookingRight:
					$playerAnimiations.play("idleRight")
				else:
					$playerAnimiations.play("idleLeft")
			else:
				if lookingRight:
					$playerAnimiations.play("runRight")
				else:
					$playerAnimiations.play("runLeft")
		else:
			if lookingRight:
				$playerAnimiations.play("dashRight")
			else:
				$playerAnimiations.play("dashLeft")
			
		
		if(Input.is_action_just_pressed("Dash") && Dashing == false):
			Dashing = true
		
		if(Dashing == true):
			if(DashTime == 0):
				velocity*=DashSpeed
			DashTime+=1
		if(DashTime == 40):
			DashTime = 0
			Dashing = false
			
		if(Dashing == true && DashTime <= 15):
			$Sprite.self_modulate.a = 0.5
		else:
			$Sprite.self_modulate.a = 1
	else:
		$playerAnimiations.play("death")
	get_parent().get_node("CanvasLayer/ArrowDisplay/ArrowCount").text = str(Arrows)
	
	move_and_slide()
	
func Damage(D):
	if PlayerHealth!=0:
		PlayerHealth-=D
		get_parent().get_node("CanvasLayer").UpdateHealth()
		if PlayerHealth == 0:
			dead = true
			velocity = Vector2.ZERO
			$deathTimer.start()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "damage":
		Damage(1)
	if(area.get_children()[0].name == "ArrowSprite"):
		if(area.DropTimer>= 20):
			Arrows+=1
			area.queue_free()


func _on_death_timer_timeout() -> void:
	get_parent().get_node("CanvasLayer").get_node("deathScreen").visible = true
	pass
