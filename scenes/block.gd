@tool
extends StaticBody2D

@export var phase: Palette.Phase = Palette.Phase.DAY:
	set(newPhase):
		phase = newPhase
		update_phase()
		
@export_flags_2d_physics var day_collision_layer
@export_flags_2d_physics var night_collision_layer

@onready var rect = Rect2(Vector2(position.x-12.5, position.y-12.5), Vector2(25,25))

func _ready():
	update_phase()
	
func _draw():
	draw_rect(Rect2(-12.5,-12.5,25.0,25.0),Color.WHITE)
	
func update_phase():
	modulate = Palette.BLOCK_COLOR_LOOKUP[phase]
	if not Engine.is_editor_hint():
		if phase == Palette.Phase.DAY:
			collision_layer = day_collision_layer
		elif phase == Palette.Phase.NIGHT:
			collision_layer = night_collision_layer

func flip():
	if phase == Palette.Phase.DAY:
		phase = Palette.Phase.NIGHT
	elif phase == Palette.Phase.NIGHT:
		phase = Palette.Phase.DAY
	CountManager.block_flipped(phase)


func _input(event:InputEvent):
	if not Engine.is_editor_hint() and event is InputEventMouseButton:
		match event.button_mask:
			MOUSE_BUTTON_MASK_RIGHT:
				flip()
			MOUSE_BUTTON_MASK_LEFT:
				if rect.has_point(event.position):
					flip()
					get_viewport().set_input_as_handled()
