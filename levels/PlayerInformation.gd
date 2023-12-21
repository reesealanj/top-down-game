extends CanvasLayer

@export var show_hud: bool = true

@onready var panel_ref: Panel = $Panel
@onready var panel_is_visible = panel_ref["visible"] 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("toggle_hud"):
		show_hud = not show_hud
		panel_ref.set_visibility_layer_bit(0, show_hud)
