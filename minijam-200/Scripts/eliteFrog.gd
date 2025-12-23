extends Area2D
var groundPound = preload("res://Scenes/ground_pound_effect.tscn")
var jumpDir = Vector2.RIGHT
var jumpDist = 3
var health = 3
var regFrame = 0
var jumping = false
var jumpStartPos = Vector2.ZERO
var t = 0
var height = 0.2
var EliteFrogGoreObj = preload("res://Scenes/EliteFrogGoreTemplate.tscn")
var deathParts = preload("res://Scenes/eliteFrogDeathParticles.tscn")

var xpLight = preload("res://Scenes/xp_light.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$start.wait_time = randf_range(0,3)
	$start.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float):
	z_index = global_position.y+70
	if jumpDir.x>0:
		$Sprite2D.flip_h = false
	else:
		$Sprite2D.flip_h = true
	if jumping:
		t+=1
		position += jumpDir*jumpDist
		$Sprite2D.position.y = height*(t-60)*t
		if t == 60:
			jumping=false
		
func jump(dir):
	jumpDir = dir
	t = 0
	jumping=true
	$Sprite2D.frame=3
	$jumpTimer.start()
	$CollisionShape2D.visible = false

func damage():
	regFrame+=1
	health-=1
	$Sprite2D.frame=regFrame
	if health == 0:
		var parts = deathParts.instantiate()
		parts.position = global_position
		get_tree().root.get_node("main").add_child(parts)
		
		
		queue_free()
		
		for i in range(5):
			var S = xpLight.instantiate()
			S.value = 15
			S.position = global_position + Vector2(randi_range(-30, 30), randi_range(-30, 30))
			get_tree().root.get_node("main").add_child(S)
		for i in range(randi_range(3, 4)):
			var S = EliteFrogGoreObj.instantiate()
			S.position = global_position + Vector2(randi_range(-30, 30), randi_range(-30, 30))
			S.rotation = randf() * TAU
			get_tree().root.add_child(S)
func _on_jump_timer_timeout() -> void:
	jumping=false
	$Sprite2D.frame=regFrame
	$CollisionShape2D.visible = true
	var aoe = groundPound.instantiate()
	aoe.global_position = global_position
	aoe.global_position.y+=100
	
	aoe.z_index=z_index-5
	aoe.scale*=1.7
	get_parent().get_parent().add_child(aoe)


func _on_jump_cooldown_timeout() -> void:
	var movementChoice = randi_range(0,10)
	if movementChoice < 4:
		var randX = randf_range(-1,1)
		var randY = randf_range(-1,1)
		var newDir = Vector2(randX,randY).normalized()
		jump(newDir)
	elif movementChoice < 9:
		var playerDir: Vector2 = get_parent().get_parent().get_node("Player").global_position - self.global_position
		jump(playerDir.normalized())


func _on_start_timeout() -> void:
	$jumpCooldown.start()
