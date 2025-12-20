extends RigidBody2D

var jumpDir = Vector2.RIGHT
var jumpDist = 3
var jumping = false
var jumpStartPos = Vector2.ZERO
var t = 0
var height = 0.2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$start.wait_time = randf_range(0,1)
	$start.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float):
	if jumping:
		t+=1
		position += jumpDir*jumpDist
		$Sprite2D.position.y = height*(t-60)*t
		
func jump(dir):
	jumpDir = dir
	t = 0
	jumping=true
	$jumpTimer.start()
	$CollisionShape2D.visible = false


func _on_jump_timer_timeout() -> void:
	print(t)
	jumping=false
	$CollisionShape2D.visible = true


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
