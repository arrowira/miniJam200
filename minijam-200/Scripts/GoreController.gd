extends Sprite2D

var Speed = 0.05
var DriftPos = 0
var RotSpeed = 0.01
var T = 0

func _ready() -> void:
	frame = randi_range(0, 3)
	DriftPos = global_position + Vector2(randi_range(-100, 100), randi_range(-100, 100))
	
func _physics_process(delta: float) -> void:
	var TDir = (DriftPos - global_position).normalized()
	position+=TDir * Speed
	
	var TAngle = (DriftPos - global_position).angle()
	rotation = lerp_angle(rotation, TAngle, RotSpeed)
	
	T+=1
	#if(T>=50):
		#Fix maybe
		#modulate.a = 1-((50/(T-49))-1)
	if(T >= 100):
		queue_free()
	
