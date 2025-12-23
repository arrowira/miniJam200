extends Node2D

var eliteFrog = preload("res://Scenes/eliteFrog.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_spawn_timer_timeout() -> void:
	var spawnChance = randi_range(0,20)
	if spawnChance == 5:
		var newFrog = eliteFrog.instantiate()
		get_tree().root.get_node("main").add_child(newFrog)
		newFrog.global_position = global_position
