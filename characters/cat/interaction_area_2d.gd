extends Area2D

@export var interactor: Node2D
@export var interaction_action: StringName = "interact"
@export var indicator_scene: PackedScene
@export var indicator_y_offset: float = 0

var selected_interactable: Interactable:
	set(value):
		if(selected_interactable == value):
			return
		
		selected_interactable = value
		
		if (selected_interactable == null):
			interaction_indicator.free();
			return
			
		_add_indicator_to_interactable(selected_interactable)

var nearby_interactables: Array[Interactable]
var interaction_indicator: Node2D
# Called when the node enters the scene tree for the first time.
func _ready():
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _input(event: InputEvent):
	if(event.is_action_pressed(interaction_action)):
		if(selected_interactable != null):
			selected_interactable.interact(interactor)
		
func _on_area_entered(area: Area2D):
	if(area is Interactable):
		nearby_interactables.push_back(area)
		if(selected_interactable == null):
			selected_interactable = nearby_interactables[0]

func _on_area_exited(area: Area2D):
	if(area is Interactable):
		nearby_interactables.erase(area)
		selected_interactable.stop_interaction(interactor)
		
		if (nearby_interactables.size() > 0):
			selected_interactable = nearby_interactables[0]
		else:
			selected_interactable = null

func _add_indicator_to_interactable(interactable: Interactable):
	if(interaction_indicator == null):
			interaction_indicator = indicator_scene.instantiate()
			interactable.add_child(interaction_indicator)
	else:
		interaction_indicator.reparent(interactable)
		
	interaction_indicator.global_position = Vector2(
		interactable.global_position.x,
		interactable.global_position.y + indicator_y_offset
	)
