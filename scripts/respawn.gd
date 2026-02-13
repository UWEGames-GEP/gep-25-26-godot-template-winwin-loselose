extends Node3D


func _on_collision_shape_3d_child_entered_tree(node: Node) -> void:
	if node.is_in_group("player"):
		node.global_transform.position = Vector3(0,0,0)
	pass
