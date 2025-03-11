extends StandardCharacter

const MOVE_SPEED = 40

var x_dir: int

func _ready():
	x_dir = -1
	sprite.play("default")


func _physics_process(delta):

	apply_gravity(delta)

	do_move()

	move_and_slide()


func do_move():
	velocity.x = x_dir * MOVE_SPEED


func turn():
	x_dir *= -1

	if 0 < x_dir:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
