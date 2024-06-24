extends Equippable_Item

class_name HarvestingTool

@export var min_damage : int = 1
@export var max_damage : int = 1
@export var effected_nodes : Array[ResourceNodeType]

func harvest(resource_node):
	pass

func interact_with_body(body):
	if(body is ResourceNode):
		for type in effected_nodes:
			if(body.node_types.has(type)):
				print("Match found at type " + type.resource_name)
				body.harvest(randi_range(min_damage, max_damage))

