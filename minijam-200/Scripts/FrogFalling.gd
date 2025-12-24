extends Node2D

var FrogGoreObj = preload("res://Scenes/FrogGoreTemplateMenu.tscn")  

func _physics_process(delta: float) -> void:
	if(randi_range(1, 3) == 1):
		for i in range(6):
			var type = randi_range(0, 3)
			var S = FrogGoreObj.instantiate()
			if(randi_range(0, 3) == 1):
				S.get_node("Gore").texture = preload("res://Sprites/WizardGore.png")
			if(randi_range(0, 3) == 1):
				S.get_node("Gore").texture = preload("res://Sprites/HealthFrogGore.png")
			if(randi_range(0, 5) == 1):
				S.get_node("Gore").texture = preload("res://Sprites/EliteFrogGore.png")
			#if(randi_range(0, 5) == 1):
				#S.get_node("Gore").texture = preload("res://Sprites/Health.png")
				#S.get_node("Gore").hframes = 1
				#S.get_node("Gore").vframes = 2
				#S.get_node("Gore").scale = Vector2(0.07, 0.07)
			#if(randi_range(0, 10) == 1):
				#S.get_node("Gore").texture = preload("res://Sprites/arrow-1.png.png")
				#S.get_node("Gore").hframes = 1
				#S.get_node("Gore").vframes = 1
				#S.get_node("Gore").scale = Vector2(0.04, 0.04)
			if(randi_range(0, 50) == 1):
				S.get_node("Gore").texture = preload("res://Sprites/eliteFrog (1).png")
				S.get_node("Gore").hframes = 3
				S.get_node("Gore").vframes = 2
				S.get_node("Gore").scale = Vector2(1, 1)
			S.get_node("Gore").MenuType = true
			S.position +=Vector2(randi_range(-300, 280), -300)
			add_child(S)
		
		
