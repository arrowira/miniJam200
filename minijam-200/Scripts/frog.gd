extends RigidBody2D

var jumpDir = Vector2.RIGHT
var jumpDist = 5
var jumping = false
var jumpStartPos = Vector2.ZERO
var t = 0
var height = 10
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("space"):
		jump(jumpDir)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float):
	if jumping:
		t+=1
		print(t)
		position.x += jumpDist*cos(t/(120*PI))
		$Sprite2D.position.y = -height*sin(t/(4*PI))6
		
func jump(dir):
	t = 0
	jumping=true
	$jumpTimer.start()
	$CollisionShape2D.visible = false


func _on_jump_timer_timeout() -> void:
	print(t)
	jumping=false
	$CollisionShape2D.visible = true
