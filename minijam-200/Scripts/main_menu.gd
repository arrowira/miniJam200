extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_settings_pressed() -> void:
	$camAnimations.play("toSettings")


func _on_back_pressed() -> void:
	$camAnimations.play("toMain")

func _on_h_slider_drag_ended(value_changed: bool) -> void:
	var db = linear_to_db($menuPT2/HSlider.value / 100.0)
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Master"),
		db
	)
