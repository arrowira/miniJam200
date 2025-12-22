extends Node2D

var UpgradeArray

func _ready() -> void:
	UpgradeArray = []
	for i in range(6):
		UpgradeArray.append(0)
	Upgraded()

# Run when anything is upgraded to update the disaplay 
func Upgraded():
	if(UpgradeArray[0]!= 0):
		$CanvasLayer/UpgradeUI/HealthUpgrade/Progress.scale = Vector2(0.4375/(8-UpgradeArray[0]), $CanvasLayer/UpgradeUI/HealthUpgrade/Progress.scale.y)
	if(UpgradeArray[1]!= 0):
		$CanvasLayer/UpgradeUI/ArrowPenetration/Progress.scale = Vector2(0.4375/(8-UpgradeArray[1]), $CanvasLayer/UpgradeUI/ArrowPenetration/Progress.scale.y)
	if(UpgradeArray[2]!= 0):
		$CanvasLayer/UpgradeUI/MoreArrows/Progress.scale = Vector2(0.4375/(8-UpgradeArray[2]), $CanvasLayer/UpgradeUI/MoreArrows/Progress.scale.y)
	if(UpgradeArray[3]!= 0):
		$CanvasLayer/UpgradeUI/Speed/Progress.scale = Vector2(0.4375/(8-UpgradeArray[3]), $CanvasLayer/UpgradeUI/Speed/Progress.scale.y)
	if(UpgradeArray[4]!= 0):
		$CanvasLayer/UpgradeUI/DashDistance/Progress.scale = Vector2(0.4375/(8-UpgradeArray[4]), $CanvasLayer/UpgradeUI/DashDistance/Progress.scale.y)
	if(UpgradeArray[5]!= 0):
		$CanvasLayer/UpgradeUI/AimSpeed/Progress.scale = Vector2(0.4375/(8-UpgradeArray[5]), $CanvasLayer/UpgradeUI/AimSpeed/Progress.scale.y)
	
func _on_button_pressed() -> void:
	get_tree().reload_current_scene()
	
