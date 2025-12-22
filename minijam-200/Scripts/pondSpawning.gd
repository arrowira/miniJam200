extends Node2D

@export var regChance = 100
@export var healthChance = 0
@export var wizardChance = 0

var radius = 3

var regFrog = preload("res://Scenes/frog.tscn")
var healFrog = preload("res://Scenes/healFrog.tscn")
var wizardFrog = preload("res://Scenes/wizard.tscn")


func _on_spawn_timer_timeout() -> void:
	var spawnAmount = randi_range(2,5)
	for i in range(spawnAmount):
		var frogType = randi_range(0,100)
		if frogType>regChance:
			if frogType>regChance+healthChance:
				if frogType > regChance+wizardChance+healthChance:
					pass
				else:
					spawnFrog("wizard")
			else:
				spawnFrog("health")
				
		else:
			spawnFrog("reg")

func spawnFrog(type):
	if type=="reg":
		var newFrog = regFrog.instantiate()
		get_parent().add_child(newFrog)
		newFrog.global_position = Vector2(global_position.x+cos(randf_range(0,180)*radius),global_position.y+sin(randf_range(0,180)*radius))
		
	
