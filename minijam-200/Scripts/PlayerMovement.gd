extends CharacterBody2D
#Who's Rem
var DefSpeed = 20
var Speed = 20
var Aiming = false
var BowCharge = 0
var ArrowObj = preload("res://Scenes/Arrow.tscn")

func _physics_process(delta: float) -> void:
	if(BowCharge >= 25 && !Input.is_mouse_button_pressed(MouseButton.MOUSE_BUTTON_LEFT)):
		BowCharge = 0
		var Arrow = ArrowObj.instantiate()
		Arrow.look_at(get_global_mouse_position())
		add_child(Arrow)
		
	if(Input.is_mouse_button_pressed(MouseButton.MOUSE_BUTTON_LEFT)):
		BowCharge+=1
	else:
		BowCharge = 0
		
	if(BowCharge > 0):
		Speed = 5
	else:
		Speed = DefSpeed
		
	var InputDir = Input.get_vector("Left","Right", "Up", "Down")
	velocity += InputDir * Speed
	velocity*=0.9
	
	move_and_slide()
