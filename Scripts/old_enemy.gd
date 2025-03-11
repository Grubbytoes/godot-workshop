extends StandardCharacter

func _physics_process(delta):
	apply_gravity(delta)
	move_and_slide()
