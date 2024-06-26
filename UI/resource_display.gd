extends MarginContainer

@export var item_display_template : PackedScene

@onready var grid_container : GridContainer = $GridContainer

var displays : Array[ResourceItemDisplay]
var player_inventory : Inventory

func _ready():
	#i created a group attached to the player named "player", there is only one player so it is fine to get the first node
	var player : Player = get_tree().get_first_node_in_group("player")
	player_inventory = player.find_child("Inventory") as Inventory
	player_inventory.connect("resource_count_changed", _on_player_resource_count_changed)

func _on_player_resource_count_changed(type : ResourceItem, new_count : int) -> void:
	print("New count for " + type.display_name + " is " + str(new_count))
	# find existing item display for type
	var current_display : ResourceItemDisplay
	
	#Look through existing displays, if type already exists update count
	for display in displays:
		if(display.resource_type == type):
			current_display = display
			current_display.update_count(new_count)
			break
	
	#If type does not exist, create new item display
	if(current_display == null):
		var new_display : ResourceItemDisplay = item_display_template.instantiate() as ResourceItemDisplay
		grid_container.add_child(new_display)
		new_display.resource_type = type
		new_display.update_count(new_count)
		
		displays.append(new_display)
			
