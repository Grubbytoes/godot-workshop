extends RigidBody2D

@export var move_speed = 50;
@export var jump_height = 200;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var movement_input = Vector2()
	
	
	# left right movement
	if Input.is_action_pressed("ui_left"):
		movement_input.x += -1
	if Input.is_action_pressed("ui_right"):
		movement_input.x += 1
	apply_force(movement_input * move_speed)
	#linear_velocity = movement_input * move_speed
	
	# Jumping
	if Input.is_action_just_pressed("ui_up"):
		apply_impulse(Vector2(0,-1) * jump_height)
