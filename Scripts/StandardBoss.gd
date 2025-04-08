extends StandardCharacter

enum STATE {NORMAL, JUMP, SLAM}

const MOVE_SPEED = 40

var x_dir: int

@export var health_bar:ProgressBar
@onready var line_of_sight: RayCast2D = $LineOfSight

var state: STATE


func _ready():
	x_dir = -1
	change_state("normal")


func _physics_process(delta):
	if state != STATE.JUMP: apply_gravity(delta)
	if state == STATE.SLAM and is_on_floor(): change_state("normal")

	check_line_of_light()
	do_move()
	move_and_slide()


func check_line_of_light():
	if line_of_sight.get_collider() != null: turn()


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


func hitbox_enter(other):
	if other.is_in_group("player_projectile"):
		take_damage(1)
		update_health_bar()


func update_health_bar():
	health_bar.value = healthPoints


func change_state(state_name):
	if state_name == "jump":
		var jump_tween = get_tree().create_tween()
		jump_tween.tween_property(self, "position", Vector2.UP * 120, 1.5).as_relative()
		jump_tween.tween_callback(self.change_state.bind("slam"))
		state = STATE.JUMP
	elif state_name == "slam":
		state = STATE.SLAM
	else:
		state = STATE.NORMAL
		$Timer.wait_time = 6.0
		$Timer.start()

