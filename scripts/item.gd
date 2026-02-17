extends Node3D

@onready var inventory
@onready var inventory_parent
@export var obj_name = "default"
var inventory_visiblity
@onready var player
@onready var charbody_lil_seb = $"."
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	inventory = get_tree().get_first_node_in_group("inventory")
	inventory_parent = get_tree().get_first_node_in_group("inventory_parent")
	pass
func type(item_type: String):
	print("type change")
	match(item_type):
		"unbreakable_katana":
			$unbreakable_katana.visible = true
		"unbreakable_katana":
			$unbreakable_katana.visible = true
		"lil_seb":
			#$unbreakable_katana.visible
			$lil_seb2.visible = true
func rigidbody():
	if self.get_parent_node_3d() != null:
		if self.get_parent_node_3d().is_in_group("stash"):
			self.global_position = get_parent_node_3d().global_position.normalized()
			self.freeze = true
		if self.get_parent_node_3d().is_in_group("item_holder"):
			self.position = Vector3(0,0,0)
			self.freeze = true
	else:
		self.freeze = false
func _physics_process(delta: float) -> void:
	if self.get_parent().is_in_group("item_holder"):
		self.position = Vector3(0,0,0)
		self.get_child(0).set_monitoring(false)
	if obj_name == "unbreakable_katana":
		rigidbody()
		
	if obj_name == "lil_seb":
		ai_follow(delta)
func ai_follow(delta):
	if self.get_parent().is_in_group("item_holder"):
		charbody_lil_seb.velocity.y = 0
	if charbody_lil_seb.is_on_floor():
		if self.global_position.y < player.global_position.y - 0.1:
			self.velocity.y += 7.5
		pass
	else:
		charbody_lil_seb.velocity.y -= 9.8 * delta
	var distance = global_position.distance_to(player.global_position)
	self.look_at(player.global_position)
	var direction = global_position.direction_to(player.global_position)
	
	#jump
	
	#moves if far
	if distance > 2.2:
		self.velocity.x = direction.x * 2
		self.velocity.z = direction.z * 2
	else:
		self.velocity.x = 0
		self.velocity.z = 0
	charbody_lil_seb.move_and_slide()
func _on_area_3d_body_shape_entered(body_rid: RID, body: Node3D, body_shape_index: int, local_shape_index: int) -> void:
	if inventory != null && body.is_in_group("player"):
		if inventory.items.size() < 6 && inventory.can_add_item:
			self.global_rotation = Vector3(0,0,0)
			inventory.addItem(self, self.get_name())
			inventory_parent.visible = true
			self.visible = false
			self.reparent(get_tree().get_first_node_in_group("stash"))
	pass # Replace with function body.
