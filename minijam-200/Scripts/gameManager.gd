extends Node2D

var UpgradeArray
var BarSize = 7.77

var skillPoints = 1
var firstUpgrade = true

func _ready() -> void:
	UpgradeArray = []
	for i in range(6):
		UpgradeArray.append(0)
	Upgraded()
	
	
func _physics_process(delta: float) -> void:
	if skillPoints != 0:
		if(Input.is_action_just_pressed("One")):
			if(UpgradeArray[0]<8):
				UpgradeArray[0]+=1
				Upgraded()
				get_node("CanvasLayer").addheart()
		if(Input.is_action_just_pressed("Two")):
			if(UpgradeArray[1]<8):
				UpgradeArray[1]+=1
				Upgraded()
				#Built into arrow script
		if(Input.is_action_just_pressed("Three")):
			if(UpgradeArray[2]<8):
				UpgradeArray[2]+=1
				Upgraded()
				get_node("Player").Arrows +=1
		if(Input.is_action_just_pressed("Four")):
			if(UpgradeArray[3]<8):
				UpgradeArray[3]+=1
				Upgraded()
				get_node("Player").DefSpeed += 1
		if(Input.is_action_just_pressed("Five")):
			if(UpgradeArray[4]<8):
				UpgradeArray[4]+=1
				Upgraded()
				get_node("Player").DashSpeed += 0.5
				get_node("Player").ImmunityFrames += 5
		if(Input.is_action_just_pressed("Six")):
			if(UpgradeArray[5]<8):
				UpgradeArray[5]+=1
				Upgraded()
				get_node("Player").BowChargeNeeded -=2

# Run when anything is upgraded to update the disaplay 
func Upgraded():
	if(UpgradeArray[0]!= 0):
		$CanvasLayer/UpgradeUI/HealthUpgrade/Progress.scale = Vector2((BarSize/8)*(UpgradeArray[0]), $CanvasLayer/UpgradeUI/HealthUpgrade/Progress.scale.y)
	if(UpgradeArray[1]!= 0):
		$CanvasLayer/UpgradeUI/ArrowPenetration/Progress.scale = Vector2((BarSize/8)*(UpgradeArray[1]), $CanvasLayer/UpgradeUI/ArrowPenetration/Progress.scale.y)
	if(UpgradeArray[2]!= 0):
		$CanvasLayer/UpgradeUI/MoreArrows/Progress.scale = Vector2((BarSize/8)*(UpgradeArray[2]), $CanvasLayer/UpgradeUI/MoreArrows/Progress.scale.y)
	if(UpgradeArray[3]!= 0):
		$CanvasLayer/UpgradeUI/Speed/Progress.scale = Vector2((BarSize/8)*(UpgradeArray[3]), $CanvasLayer/UpgradeUI/Speed/Progress.scale.y)
	if(UpgradeArray[4]!= 0):
		$CanvasLayer/UpgradeUI/DashDistance/Progress.scale = Vector2((BarSize/8)*(UpgradeArray[4]), $CanvasLayer/UpgradeUI/DashDistance/Progress.scale.y)
	if(UpgradeArray[5]!= 0):
		$CanvasLayer/UpgradeUI/AimSpeed/Progress.scale = Vector2((BarSize/8)*(UpgradeArray[5]), $CanvasLayer/UpgradeUI/AimSpeed/Progress.scale.y)
	skillPoints-=1
	$CanvasLayer/UpgradeUI/Control/skillPoints.text = "x"+str(skillPoints)
	if firstUpgrade:
		firstUpgrade = false
	else:
		$skillPoint.play()
		
	
	
func _on_button_pressed() -> void:
	get_tree().reload_current_scene()
func addSkillPoint():
	skillPoints+=1
	$CanvasLayer/UpgradeUI/Control/skillPoints.text = "x"+str(skillPoints)
