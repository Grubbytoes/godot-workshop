class_name StandardCharacter
extends CharacterBody2D

const CHARACTER_GRAVITY = 500

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var poof := load("res://Scenes/Prefabs/poof.tscn")
func apply_gravity(delta):
	velocity.y += CHARACTER_GRAVITY * delta


func die():
	print("dead")
	var new_poof:GPUParticles2D = poof.instantiate()
	add_sibling(new_poof)
	new_poof.emitting = true
	new_poof.position = position
	queue_free()
	
