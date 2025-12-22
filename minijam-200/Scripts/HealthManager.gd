extends CanvasLayer

var heart = preload("res://Scenes/heart.tscn") 
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("space"):
		addheart()

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
	newHeart.position.x = 10+16*(get_parent().get_node("Player").maxHealth-1)
	
