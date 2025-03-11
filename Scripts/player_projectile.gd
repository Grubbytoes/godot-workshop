extends Node2D


var launch_direction: Vector2 = Vector2.UP
var speed: float = 360


func launch(initial_position: Vector2, direction: Vector2):
	self.position = initial_position
	self.launch_direction = direction


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position += launch_direction * speed * delta
