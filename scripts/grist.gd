extends RigidBody3D

@onready var game_manager
#do something with this ig
@export_enum("blue", "green", "red")  var num: int


func _ready() -> void:
	game_manager = get_tree().get_first_node_in_group("game_manager")
	pass


func _on_area_3d_body_shape_entered(body_rid: RID, body: Node3D, body_shape_index: int, local_shape_index: int) -> void:
	if game_manager != null && body.is_in_group("player"):
		game_manager.grist_pickup_timer = 3.0
		game_manager.pickup_sfx.play()
		game_manager.grist += 10 #make a value based on type later
		game_manager.grist_change_visual()
		self.queue_free()
	pass # Replace with function body.
