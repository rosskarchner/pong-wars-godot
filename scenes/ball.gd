@tool
extends CharacterBody2D


# Huh? I attempted to reverse-engineer these speeds from the JS
# version of Pong Wars, which manages the velocity directly, instead of
# treating it as the product of speed and direction. The JS version moves some
# number of pixels in x and y each *frame*, and does not take actual time into
# account.
var MIN_SPEED:=700
var MAX_SPEED:=900
var SPEED:=800

var DIRECTION:=Vector2.ZERO
@onready var shapecast = $ShapeCast2D

@export var phase: Palette.Phase:
	set(newPhase):
		modulate = Palette.BLOCK_COLOR_LOOKUP[newPhase]
		phase = newPhase


func _ready():
	if phase == Palette.Phase.DAY:
		DIRECTION = Vector2.LEFT + Vector2.DOWN
		shapecast.collision_mask = 4
	else:
		DIRECTION = Vector2.RIGHT + Vector2.UP
		shapecast.collision_mask = 8
	DIRECTION.x *= randf()
	DIRECTION.y *= randf()
	DIRECTION = DIRECTION.normalized()
	velocity = DIRECTION * SPEED

func _draw():
	draw_circle(Vector2.ZERO,12.5,Color.WHITE)

func _physics_process(delta):
	if not Engine.is_editor_hint():
		var collision_info = move_and_collide(velocity * delta,false,0.62)
		if collision_info:
			DIRECTION = velocity.bounce(collision_info.get_normal()).normalized()

			# stuck up and down? add a little x
			if abs(DIRECTION.x) < 0.2 and abs(DIRECTION.y) > 0.8:
				DIRECTION.x += (.1 if DIRECTION.x > 0 else -.1)
				
			# stuck left and right? add a little y
			elif abs(DIRECTION.y) < 0.2 and abs(DIRECTION.x) > 0.8:
				DIRECTION.y += (.1 if DIRECTION.y > 0 else -.1)
			else:
				# just add a little randomness to direction
				DIRECTION.x -=[-0.1, 0.1].pick_random() * randf()
				DIRECTION.y -=[-0.1, 0.1].pick_random() * randf()
				
			# add a little randomness to speed
			SPEED = clamp(SPEED + (randf() *20) -10, MIN_SPEED,MAX_SPEED)
			velocity = DIRECTION * SPEED
			
			
			shapecast.force_shapecast_update()
			if shapecast.is_colliding():
				for i in range(shapecast.get_collision_count()):

					var collider = shapecast.get_collider(i)
					if collider.is_in_group("blocks"):
						collider.flip()
			

