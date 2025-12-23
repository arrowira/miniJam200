extends RigidBody2D

@export var speed := 80.0
var lifetime = 300
var life = 0
var player_dir := Vector2.ZERO

var parts = preload("res://Scenes/wizard_particles.tscn")

func _ready() -> void:
	$projArea/AnimationPlayer.play("spawn")
func _physics_process(delta: float) -> void:
	life+=1
	if life == lifetime:
		$projArea/AnimationPlayer.play("die")
	if life == lifetime+20:
		queue_free()
func launch(from_pos: Vector2, target_pos: Vector2) -> void:
	player_dir = (target_pos - from_pos).normalized()
	linear_velocity = player_dir * speed


func _on_proj_area_area_entered(area: Area2D) -> void:
	if area.name == "playerArea":
		area.get_parent().Damage(1)
		var parts = parts.instantiate()
		parts.global_position=global_position
		get_tree().root.get_node("main").add_child(parts)
		
		
		queue_free()
