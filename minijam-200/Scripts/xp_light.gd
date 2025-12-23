extends Sprite2D

var value = 3
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	var playerPos = get_tree().root.get_node("main/Player").global_position
	var myPos = global_position
	global_position += (playerPos-myPos).normalized()*3
	if myPos.distance_to(playerPos)<5:
		pop()
func pop():
	get_parent().get_node("CanvasLayer").get_node("XPbar").addXP(value)
	queue_free()
