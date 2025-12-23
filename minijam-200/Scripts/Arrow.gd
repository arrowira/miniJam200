extends Area2D

var FrogGoreObj = preload("res://Scenes/FrogGoreTemplate.tscn") 
var WizardFrogGoreObj = preload("res://Scenes/WizardFrogGoreTemplate.tscn") 
var HealthFrogGoreObj = preload("res://Scenes/HealthFrogGoreTemplate.tscn") 
var HealObj = preload("res://Scenes/HealObject.tscn")
var xpLight = preload("res://Scenes/xp_light.tscn")


var DropTimer = 0
var GreenParts = preload("res://Scenes/green_frog_death_particles.tscn")
var ArrowSpeed = 15
var ArrowSlow = 10
var Dropped = false
var CanDrop = true

func _physics_process(delta: float) -> void:
	if !CanDrop:
		global_position += transform.x * 15
	else:
		if(DropTimer<=25):
			global_position += transform.x * ArrowSpeed
		else:
			$CPUParticles2D.visible = false
			Dropped = true
	DropTimer+=1
	ArrowSlow = 10 - (get_tree().current_scene.UpgradeArray[1]*2)
	
	

func _on_area_entered(area: Area2D) -> void:
	if area.name == "frogArea2D":
		if(Dropped == false):
			$DeathSound.play()
			if(area.get_children()[0].name == "EliteFrog"):
				area.damage()
			else:
				area.get_parent().queue_free()
			if(area.get_children()[0].name == "NormalFrog"):
				SpawnFrogGore(1)
			if(area.get_children()[0].name == "WizardFrog"):
				SpawnFrogGore(2)
			if(area.get_children()[0].name == "HealFrog"):
				SpawnFrogGore(3)
				var S = HealObj.instantiate()
				S.global_position = area.global_position
				get_parent().get_parent().add_child(S)
			var parts = GreenParts.instantiate()
			parts.global_position = global_position
			get_parent().get_parent().add_child(parts)
			if(ArrowSpeed - ArrowSlow > 0):
				ArrowSpeed -= ArrowSlow
		
func SpawnFrogGore(type):
	for i in range(randi_range(2, 3)):
		var S
		var xp = xpLight.instantiate()
		if(type == 1):
			S = FrogGoreObj.instantiate()
			xp.value=10
		if(type == 2):
			S = WizardFrogGoreObj.instantiate() 
			xp.value=30
		if(type == 3):
			S = HealthFrogGoreObj.instantiate()
			xp.value=20
		xp.position = global_position
		S.position = global_position + Vector2(randi_range(-20, 20), randi_range(-20, 20))
		S.rotation = randf() * TAU
		get_tree().root.get_node("main").add_child(S)
		get_tree().root.get_node("main").add_child(xp)


func _on_body_entered(body: Node2D) -> void:
	if(body.name == "pondCol"):
		CanDrop = false
	
func _on_body_exited(body: Node2D) -> void:
	if(body.name == "pondCol"):
		CanDrop = true
