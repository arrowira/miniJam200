extends CharacterBody2D
#Who's Rem
var DefSpeed = 20
var Speed = 20
var Aiming = false

func _physics_process(delta: float) -> void:
	if(Aiming == true):
		Speed = 5
	else:
		Speed = DefSpeed
		
	var InputDir = Input.get_vector("Left","Right", "Up", "Down")
	velocity += InputDir * Speed
	velocity*=0.9
	
	
	
	move_and_slide()
