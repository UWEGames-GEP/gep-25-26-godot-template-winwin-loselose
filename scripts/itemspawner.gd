extends Node3D

var timer = 0
var base_grist = load("res://nodes/item.tscn")

#PUT MATERIALS HERE

func _physics_process(delta: float) -> void:
	if timer >= 0:
		timer -= 1.0 * delta
	else:
		var instance = base_grist.instantiate()	
		#instance.set_position(self.global_position)
		add_child(instance)
		var rng = RandomNumberGenerator.new()
		timer = rng.randf_range(4.0, 12.0)
