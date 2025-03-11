extends Camera2D

@export var target: Node2D


func _process(delta):
	if target == null: return

	self.position = lerp(self.position, target.position, 20*delta)
