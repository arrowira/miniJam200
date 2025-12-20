extends Area2D

var DespawnTimer = 0

func _physics_process(delta: float) -> void:
	global_position += transform.x * 35
	
