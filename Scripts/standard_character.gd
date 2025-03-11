class_name StandardCharacter
extends CharacterBody2D

const CHARACTER_GRAVITY = 500

@onready var sprite: AnimatedSprite2D = $Sprite

func apply_gravity(delta):
	velocity.y += CHARACTER_GRAVITY * delta


func die():
	queue_free()