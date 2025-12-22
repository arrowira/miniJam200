extends RigidBody2D

@export var speed := 80.0
var player_dir := Vector2.ZERO

func _ready() -> void:
	$projArea/AnimationPlayer.play("spawn")

func launch(from_pos: Vector2, target_pos: Vector2) -> void:
	player_dir = (target_pos - from_pos).normalized()
	linear_velocity = player_dir * speed
