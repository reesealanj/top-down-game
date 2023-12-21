extends Interactable

@export var is_open = false

func interact(user: Node2D):
	is_open = not is_open
	print('chest open' if is_open == true else 'chest closed')

func stop_interaction(user: Node2D):
	is_open = false
