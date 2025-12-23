extends Node2D

var speed = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HeartHitbox/AnimationPlayer.play("heartBeat")


func _physics_process(delta: float) -> void:
	var playerPos = Vector2.ZERO
	if get_tree().root.get_node("main/Player") != null:
		playerPos = get_tree().root.get_node("main/Player").global_position
	var myPos = global_position
	global_position += (playerPos-myPos).normalized()*speed
	speed+=0.005
