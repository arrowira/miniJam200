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

var PlayerHealth = 3

func _physics_process(delta: float) -> void:
	z_index = global_position.y-12
	if(!Input.is_mouse_button_pressed(MouseButton.MOUSE_BUTTON_LEFT)):
		if BowCharge >=25:
			$shoot.play()
			BowCharge = 0
			var Arrow = ArrowObj.instantiate()
			var MousePos = get_global_mouse_position()
			var Aim = (MousePos - global_position).angle()
			Arrow.rotation = Aim
			add_child(Arrow)
		
	if BowCharge==0 and Input.is_action_just_pressed("shoot"):
		$BowPivot/AnimationPlayer.play("shootBow")
		$charge.play()
	if Input.is_action_just_released("shoot"):
		$BowPivot/AnimationPlayer.play("RESET")
		$BowPivot/Bow.frame = 0
	if(Input.is_mouse_button_pressed(MouseButton.MOUSE_BUTTON_LEFT)):
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
	
	move_and_slide()
	
func Damage(D):
	PlayerHealth-=D
	get_parent().get_node("CanvasLayer").UpdateHealth()
	


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "damage":
		print("damaged")
		Damage(1)
