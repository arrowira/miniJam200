extends Area2D

var DespawnTimer = 0

func _physics_process(delta: float) -> void:
	global_position += transform.x * 15
	


func _on_area_entered(area: Area2D) -> void:
	if area.name == "frogArea2D":
		area.get_parent().queue_free()
