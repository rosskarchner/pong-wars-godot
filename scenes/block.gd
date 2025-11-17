@tool
extends StaticBody2D

@export var phase: Palette.Phase = Palette.Phase.DAY:
	set(newPhase):
		phase = newPhase
		update_phase()
		
@export_flags_2d_physics var day_collision_layer
@export_flags_2d_physics var night_collision_layer

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
	if not Engine.is_editor_hint() and event is InputEventMouseButton and event.pressed:
		# Create a rect in global coordinates centered on this block's position
		var global_rect = Rect2(global_position - Vector2(12.5, 12.5), Vector2(25, 25))

		if event.button_index == MOUSE_BUTTON_LEFT and global_rect.has_point(event.position):
			flip()
			get_viewport().set_input_as_handled()
		elif event.button_index == MOUSE_BUTTON_RIGHT and global_rect.has_point(event.position):
			flip()
			get_viewport().set_input_as_handled()
