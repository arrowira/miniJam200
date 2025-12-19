extends CharacterBody2D
#Who's Rem
var Speed = 20

func _physics_process(delta: float) -> void:
	var InputDir = Input.get_vector("Left","Right", "Up", "Down")
	velocity += InputDir * Speed
	velocity*=0.9
	
	move_and_slide()
