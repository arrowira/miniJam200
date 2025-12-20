extends CanvasLayer

func UpdateHealth():
	match get_parent().get_node("Player").PlayerHealth:
		1:
			$Health1.frame = 0
			$Health2.frame = 1
			$Health3.frame = 1
		2:
			$Health1.frame = 0
			$Health2.frame = 0
			$Health3.frame = 1
		3:
			$Health1.frame = 0
			$Health2.frame = 0
			$Health3.frame = 0
