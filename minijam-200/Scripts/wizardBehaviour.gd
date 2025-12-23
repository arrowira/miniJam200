extends Area2D
var groundPound = preload("res://Scenes/ground_pound_effect.tscn")
var projectile = preload("res://Scenes/wizard_projectile.tscn")
var teleDir = Vector2.RIGHT
var teleDist = 200

var jumpStartPos = Vector2.ZERO
var t = 0
var height = 0.2

var inWater = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$start.wait_time = randf_range(0,1)
	$start.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float):
	if inWater:
		$Sprite2D.visible=false
		$Shadow1_png.visible=false
	else:
		$Sprite2D.visible=true
		$Shadow1_png.visible=true
	
	z_index = global_position.y
		
func teleport(dir):
	teleDir = dir
	global_position += teleDir*teleDist
	$AnimationPlayer.play('teleport')
	$portal.visible = true
	$teleportTimer.start()
	$CollisionShape2D.visible = false


func _on_tele_timer_timeout() -> void:
	$portal.visible = false
	$CollisionShape2D.visible = true
	$teleCooldown.start()


func _on_tele_cooldown_timeout() -> void:
	var movementChoice = randi_range(0,10)
	if movementChoice < 4:
		var randX = randf_range(-1,1)
		var randY = randf_range(-1,1)
		var newDir = Vector2(randX,randY).normalized()
		teleport(newDir)
	elif movementChoice < 9:
		var playerDir: Vector2 = get_parent().get_parent().get_node("Player").global_position - self.global_position
		teleport(playerDir.normalized())


func _on_start_timeout() -> void:
	$teleCooldown.start()


func _on_shoot_timer_timeout() -> void:
	$shootTimer.wait_time = randf_range(1.5,2.5)
	var newProj = projectile.instantiate()
	
	
	get_parent().get_parent().add_child(newProj)
	newProj.global_position = global_position
	newProj.launch(global_position, get_parent().get_parent().get_node("Player").global_position)


func _on_area_entered(area: Area2D) -> void:
	if area.name=="pond":
		inWater=true


func _on_area_exited(area: Area2D) -> void:
	if area.name == "pond":
		inWater=false
