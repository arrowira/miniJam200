extends Area2D

var FrogGoreObj = preload("res://Scenes/FrogGoreTemplate.tscn") 
var WizardFrogGoreObj = preload("res://Scenes/WizardFrogGoreTemplate.tscn") 

var DropTimer = 0
var GreenParts = preload("res://Scenes/green_frog_death_particles.tscn")
var ArrowSpeed = 15
var ArrowSlow = 10
var Dropped = false

func _physics_process(delta: float) -> void:
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
			area.get_parent().queue_free()
			if(area.get_children()[0].name == "NormalFrog"):
				SpawnFrogGore(1)
			if(area.get_children()[0].name == "WizardFrog"):
				SpawnFrogGore(2)
			if(area.get_children()[0].name == "HealFrog"):
				get_parent().get_node("CanvasLayer").heal()
			var parts = GreenParts.instantiate()
			parts.global_position = global_position
			get_parent().get_parent().add_child(parts)
			if(ArrowSpeed - ArrowSlow > 0):
				ArrowSpeed -= ArrowSlow
		
func SpawnFrogGore(type):
	for i in range(randi_range(3, 5)):
		var S
		if(type == 1):
			S = FrogGoreObj.instantiate()
		if(type == 2):
			S = WizardFrogGoreObj.instantiate() 
		S.position = global_position + Vector2(randi_range(-20, 20), randi_range(-20, 20))
		S.rotation = randf() * TAU
		get_tree().root.add_child(S)
