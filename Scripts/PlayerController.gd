extends StandardCharacter

const PLAYER_MOVE_SPEED = 120
const PLAYER_JUMP_FORCE = 250

var jump_count: int
var move_dir: Vector2
var face_dir: Vector2

@export var lives:int = 3
@export var respawn_position:Node2D
@export var lives_label:Label
@export var collectable_label:Label
var projectile_scene := load("res://Scenes/Prefabs/player_projectile.tscn")
var fruit_count = 0

func _ready():
	sprite.play("idle")
	jump_count = 2
	lives_label.text = ("Lives: " + str(lives))


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
	if Input.is_action_just_pressed("ui_up") and can_jump():
		velocity.y -= PLAYER_JUMP_FORCE	
	
	# listening for shooting call
	if Input.is_action_just_pressed("shoot"):
		shoot()
	
	# Gravity
	apply_gravity(delta)

	# Drag
	if move_dir.x == 0:
		if 1 < abs(velocity.x):
			velocity.x = lerp(velocity.x, 0.0, 0.15)
		else:
			velocity.x = 0
	
	move_and_slide()
	if 0 < velocity.length():
		face_dir = velocity.normalized()


func can_jump():
	if is_on_floor():
		jump_count = 2
	
	if 0 < jump_count:
		jump_count -= 1
		return true
	else:
		return false

func collectable_pickup():
	fruit_count += 1
	collectable_label.text = "Fruit: " + str(fruit_count)
	

func hitbox_enter(other):
	if other.is_in_group("player_hurt"):
		die()


func shoot():
	var new_projectile = projectile_scene.instantiate()
	add_sibling(new_projectile)
	new_projectile.launch(self.position, face_dir)


func die():
	if lives <= 0:
		true_die()
	else:
		respawn()
	
func respawn():
	create_poof()
	position = respawn_position.position
	lives -= 1
	lives_label.text = ("Lives: " + str(lives))
	

func true_die():
	print("Player dying")
	get_tree().change_scene_to_file("res://Scenes/Menus/main_menu.tscn")
	super.die()
