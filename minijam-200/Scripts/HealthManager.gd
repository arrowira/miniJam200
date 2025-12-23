extends CanvasLayer

var heart = preload("res://Scenes/heart.tscn") 
func _process(delta: float) -> void:
	pass

func UpdateHealth():
	$hearts.get_children()[get_parent().get_node("Player").PlayerHealth].frame=1
		
func addheart():
	var max = get_parent().get_node("Player").maxHealth
	var current =get_parent().get_node("Player").PlayerHealth
	var newHeart = heart.instantiate()
	$hearts.add_child(newHeart)
	
	get_parent().get_node("Player").maxHealth+=1
	get_parent().get_node("Player").PlayerHealth+=1
	
	$hearts.move_child(newHeart,$hearts.get_children().size()-1)
	
	
	if max-current !=0:
		$hearts.get_children()[get_parent().get_node("Player").PlayerHealth-1].frame=0
		newHeart.frame=1
	newHeart.position.y = 9
	newHeart.position.x = 10+18*(get_parent().get_node("Player").maxHealth-1)
	
func heal():
	if get_parent().get_node("Player").PlayerHealth != get_parent().get_node("Player").maxHealth:
		get_parent().get_node("Player").PlayerHealth+=1
		$hearts.get_children()[get_parent().get_node("Player").PlayerHealth-1].frame=0
	
	
	
	
