extends Node2D

@export var regChance = 100
@export var healthChance = 0
@export var wizardChance = 0

@export var radius = 3

var regFrog = preload("res://Scenes/frog.tscn")
var healFrog = preload("res://Scenes/healFrog.tscn")
var wizardFrog = preload("res://Scenes/wizard.tscn")

var spawnCoolDown = 10


func _ready() -> void:
	$spawnTimer.wait_time=spawnCoolDown


func _on_spawn_timer_timeout() -> void:
	var spawnAmount = randi_range(1,3)
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
	var newFrog
	if type=="reg":
		newFrog = regFrog.instantiate()
	if type =="health":
		newFrog = healFrog.instantiate()
	if type == "wizard":
		newFrog = wizardFrog.instantiate()
	get_parent().add_child(newFrog)
	newFrog.global_position = Vector2(global_position.x+cos(randf_range(0,180)*radius),global_position.y+sin(randf_range(0,180)*radius))
	
		
	
