extends Area2D

var FrogGoreObj = preload("res://Scenes/FrogGoreTemplate.tscn") 

var DropTimer = 0
var GreenParts = preload("res://Scenes/green_frog_death_particles.tscn")
var ArrowSpeed = 15

func _physics_process(delta: float) -> void:
	if(DropTimer<=25):
		global_position += transform.x * 15
	else:
		$CPUParticles2D.visible = false
	DropTimer+=1
	

func _on_area_entered(area: Area2D) -> void:
	if area.name == "frogArea2D":
		$DeathSound.play()
		area.get_parent().queue_free()
		SpawnFrogGore()
		var parts = GreenParts.instantiate()
		parts.global_position = global_position
		get_parent().get_parent().add_child(parts)
		
		
func SpawnFrogGore():
	for i in range(randi_range(3, 5)):
		var S = FrogGoreObj.instantiate()
		S.position = global_position + Vector2(randi_range(-20, 20), randi_range(-20, 20))
		S.rotation = randf() * TAU
		get_tree().root.add_child(S)
