extends Sprite2D

class_name HandEquip

@onready var equip_hitbox : Area2D = $Area2D
@export var equipped_item : EquippableItem :
	set(next_equipped):
		equipped_item = next_equipped
		self.texture = next_equipped.texture
		print("setting new equipped item " + next_equipped.display_name)

#func connected to the area2D, interact with body comes from harvesting_tool, which is a script for pickaxe resource
func _on_area_2d_body_entered(body):
	if(equipped_item.has_method("interact_with_body")):
		equipped_item.interact_with_body(body)
