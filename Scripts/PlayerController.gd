extends CharacterBody2D

const PLAYER_MOVE_SPEED = 120
const PLAYER_JUMP_FORCE = 250

var move_dir: Vector2 

@onready var sprite: AnimatedSprite2D = $Sprite

func _ready():
	sprite.play("idle")

func _physics_process(delta):
	move_dir = Vector2.ZERO
	
	# left right movement
	if Input.is_action_pressed("ui_left"):
		move_dir.x += -1
		sprite.flip_h = true
		sprite.play("run")
	elif Input.is_action_pressed("ui_right"):
		move_dir.x += 1
		sprite.flip_h = false
		sprite.play("run")
	else:
		sprite.play("idle")
	
	velocity.x += move_dir.x * PLAYER_MOVE_SPEED * delta * 4
	velocity.x = clamp(velocity.x, -PLAYER_MOVE_SPEED, PLAYER_MOVE_SPEED)

	# Jumping
	if Input.is_action_just_pressed("ui_up"):
		velocity.y -= PLAYER_JUMP_FORCE	
	
	# Gravity
	velocity.y += 500 * delta

	# Drag
	if move_dir.x == 0:
		if 1 < abs(velocity.x):
			velocity.x = lerp(velocity.x, 0.0, 0.15)
		else:
			velocity.x = 0
	
	move_and_slide()
