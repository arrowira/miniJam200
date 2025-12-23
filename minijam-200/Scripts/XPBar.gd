extends Node

var xp=0
var lvl = 0

var lvlLengthMod = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("space"):
		addXP(10)

func addXP(amt):
	xp+=int(amt*lvlLengthMod)
	if xp>=100:
		xp=xp%100
		lvl += 1
		$lvlLabel.text = str(lvl)
		get_tree().root.get_node("main").addSkillPoint()
		lvlLengthMod *= 0.9
	
	
	$ProgressBar.value=xp
