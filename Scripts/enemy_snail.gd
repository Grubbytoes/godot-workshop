extends StandardCharacter

const MOVE_SPEED = 40

var x_dir: int

@onready var line_of_sight = $LineOfSight

func _ready():
	x_dir = -1
	sprite.play("default")


func _physics_process(delta):

	apply_gravity(delta)

	do_move()

	move_and_slide()


func do_move():
	if not is_on_floor():
		velocity.x = 0
		return
		
	velocity.x = x_dir * MOVE_SPEED


func turn():
	x_dir *= -1
	line_of_sight.scale.x = -x_dir

	if 0 < x_dir:
		sprite.flip_h = true
	else:
		sprite.flip_h = false


func body_entered_sight(body):
	turn()


func hitbox_enter(other):
	if not other.is_in_group("player_projectile"):
		return
	
	die()
