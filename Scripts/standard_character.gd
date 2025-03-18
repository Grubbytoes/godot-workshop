class_name StandardCharacter
extends CharacterBody2D

const CHARACTER_GRAVITY = 500

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var poof:= load("res://Scenes/Prefabs/poof.tscn")

func apply_gravity(delta):
	velocity.y += CHARACTER_GRAVITY * delta


func create_poof():
	var new_poof = poof.instantiate()
	add_sibling(new_poof)
	new_poof.emitting = true
	new_poof.position = self.position

func die():
	create_poof()
	queue_free()
	
