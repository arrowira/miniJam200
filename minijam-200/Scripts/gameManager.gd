extends Node2D

var UpgradeArray

func _ready() -> void:
	UpgradeArray = []
	for i in range(6):
		UpgradeArray.append(0)
	Upgraded()
	
	
func _physics_process(delta: float) -> void:
	if(Input.is_action_just_pressed("One")):
		UpgradeArray[0]+=1
		Upgraded()
		get_node("CanvasLayer").addheart()
	if(Input.is_action_just_pressed("Two")):
		UpgradeArray[1]+=1
		Upgraded()
		#Built into arrow script
	if(Input.is_action_just_pressed("Three")):
		UpgradeArray[2]+=1
		Upgraded()
		get_node("Player").Arrows +=1
	if(Input.is_action_just_pressed("Four")):
		UpgradeArray[3]+=1
		Upgraded()
		get_node("Player").DefSpeed += 5
	if(Input.is_action_just_pressed("Five")):
		UpgradeArray[4]+=1
		Upgraded()
		get_node("Player").DashSpeed += 1
	if(Input.is_action_just_pressed("Six")):
		UpgradeArray[5]+=1
		Upgraded()
		get_node("Player").BowChargeNeeded -=3

# Run when anything is upgraded to update the disaplay 
func Upgraded():
	if(UpgradeArray[0]!= 0):
		$CanvasLayer/UpgradeUI/HealthUpgrade/Progress.scale = Vector2((0.4375/8)*(UpgradeArray[0]), $CanvasLayer/UpgradeUI/HealthUpgrade/Progress.scale.y)
	if(UpgradeArray[1]!= 0):
		$CanvasLayer/UpgradeUI/ArrowPenetration/Progress.scale = Vector2((0.4375/8)*(UpgradeArray[1]), $CanvasLayer/UpgradeUI/ArrowPenetration/Progress.scale.y)
	if(UpgradeArray[2]!= 0):
		$CanvasLayer/UpgradeUI/MoreArrows/Progress.scale = Vector2((0.4375/8)*(UpgradeArray[2]), $CanvasLayer/UpgradeUI/MoreArrows/Progress.scale.y)
	if(UpgradeArray[3]!= 0):
		$CanvasLayer/UpgradeUI/Speed/Progress.scale = Vector2((0.4375/8)*(UpgradeArray[3]), $CanvasLayer/UpgradeUI/Speed/Progress.scale.y)
	if(UpgradeArray[4]!= 0):
		$CanvasLayer/UpgradeUI/DashDistance/Progress.scale = Vector2((0.4375/8)*(UpgradeArray[4]), $CanvasLayer/UpgradeUI/DashDistance/Progress.scale.y)
	if(UpgradeArray[5]!= 0):
		$CanvasLayer/UpgradeUI/AimSpeed/Progress.scale = Vector2((0.4375/8)*(UpgradeArray[5]), $CanvasLayer/UpgradeUI/AimSpeed/Progress.scale.y)
	
func _on_button_pressed() -> void:
	get_tree().reload_current_scene()
	
