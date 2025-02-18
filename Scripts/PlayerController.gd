extends RigidBody2D

@onready var anim: AnimationPlayer = $Anim
@onready var sprite: Sprite2D = $Sprite

@export var move_speed = 50
@export var jump_height = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var movement_input = Vector2()
	
	
	# left right movement
	if Input.is_action_pressed("ui_left"):
		movement_input.x += -1
		sprite.flip_h = true
	if Input.is_action_pressed("ui_right"):
		movement_input.x += 1
		sprite.flip_h = false
	apply_force(movement_input * move_speed)
	#linear_velocity = movement_input * move_speed
	
	# Jumping
	if Input.is_action_just_pressed("ui_up"):
		apply_impulse(Vector2(0,-1) * jump_height)
