extends RigidBody2D

var jumpDir = Vector2.RIGHT
var jumpDist = 5
var jumping = false
var jumpStartPos = Vector2.ZERO
var t = 0
var height = 0.3
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Space"):
		jump(jumpDir)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float):
	if jumping:
		t+=1
		print(t)
		position += jumpDir*jumpDist
		$Sprite2D.position.y = height*(t-60)*t
		
func jump(dir):
	t = 0
	jumping=true
	$jumpTimer.start()
	$CollisionShape2D.visible = false


func _on_jump_timer_timeout() -> void:
	print(t)
	jumping=false
	$CollisionShape2D.visible = true
