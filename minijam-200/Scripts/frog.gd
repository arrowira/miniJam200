extends Area2D
var groundPound = preload("res://Scenes/ground_pound_effect.tscn")
var jumpDir = Vector2.RIGHT
var jumpDist = 3
var jumping = false
var jumpStartPos = Vector2.ZERO
var t = 0
var height = 0.2

var inWater = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$start.wait_time = randf_range(0,3)
	$start.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float):
	if inWater and !jumping:
		$Sprite2D.visible=false
		$Shadow1_png.visible=falseaa
	else:
		$Sprite2D.visible=true
		$Shadow1_png.visible=true
	z_index = global_position.y
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
	inWater = false
	$Sprite2D.frame=1
	$jumpTimer.start()
	$CollisionShape2D.visible = false


func _on_jump_timer_timeout() -> void:
	jumping=false
	
	$Sprite2D.frame=0
	$CollisionShape2D.visible = true
	var aoe = groundPound.instantiate()
	aoe.global_position = global_position
	aoe.global_position.y+=35
	
	aoe.z_index=z_index-5
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


func _on_body_entered(body: Node2D) -> void:
	if body.name == "pond":
		inWater=true
