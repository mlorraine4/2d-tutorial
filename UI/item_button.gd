@tool
#runs script in the editor
extends Button

class_name ItemButton

@export var item : Item :
	set(new_item):
		item = new_item
		icon = item.texture

var hand_equip : HandEquip

func _ready():
	if(not Engine.is_editor_hint()):
		connect("pressed", _on_pressed)

func _on_pressed():
	#makes sure doesn't run in editor only in game
	if(not Engine.is_editor_hint()):
		if(item is EquippableItem):
			if(hand_equip != null):
				#set equipped_item from HandEquip Node to item
				hand_equip.equipped_item = item

