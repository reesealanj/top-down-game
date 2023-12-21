extends CharacterBody2D

@export_group("Movement Controls")
@export var movement_speed: float = 100
@export var starting_position: Vector2 = Vector2(0, 1)
@export var is_sprintint: bool = false

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var state_machine = animation_tree["parameters/playback"]

func _ready():
	update_animation_tree(starting_position)

func _physics_process(delta):
	# show or hide menu
	if(Input.is_action_pressed("sprint")):
		movement_speed = 155
	
	if(Input.is_action_just_released("sprint")):
		movement_speed = 100
	# 1. get direction of player input
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	update_animation_tree(input_direction)
	
	# 2. compute the current velocity
	velocity = input_direction * movement_speed
	
	pick_new_state()
	move_and_slide()

	
func update_animation_tree(move_input: Vector2):
	if (move_input != Vector2.ZERO):
		animation_tree.set("parameters/Walk/blend_position", move_input)
		animation_tree.set("parameters/Idle/blend_position", move_input)


func pick_new_state(): 
	if (velocity != Vector2.ZERO):
		state_machine.travel("Walk", false)
	else:
		state_machine.travel("Idle", false)
