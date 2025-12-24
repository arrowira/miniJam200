extends Node

var xp=0
var lvl = 0

var lvlLengthMod = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("space"):
		addXP(100)

func addXP(amt):
	$AudioStreamPlayer.play()
	$AudioStreamPlayer.pitch_scale = 1 + randf_range(0,0.5)
	xp+=int(amt*lvlLengthMod)
	if xp>=100:
		xp=xp%100
		lvl += 1
		$lvlSFX.play()
		$lvlLabel.text = str(lvl)
		get_tree().root.get_node("main").addSkillPoint()
		lvlLengthMod *= 0.95
	
	
	$ProgressBar.value=xp
