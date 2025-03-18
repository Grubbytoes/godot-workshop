class_name Collectable
extends Node2D

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var player = %Player

func _ready():
	sprite.play('default')


func picked_up(body):
	if not body.is_in_group("player_pickup"):
		return 
	
	sprite.play("picked_up")
	player.collectable_pickup()

	var timer := Timer.new()
	add_child(timer)
	timer.timeout.connect(func():
		print("Goodbye!")
		queue_free()
	)
	timer.start()
