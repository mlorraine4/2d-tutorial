extends Control

@onready var player : Player = get_tree().get_first_node_in_group("player")
var hand_equip : HandEquip

@onready var grid_container : GridContainer = $GridContainer

#connect the HandEquip class to each button, more efficient to find the player once in Control instead of finding player in each button
func _ready():
	if(player):
		#this didn't work unless i renamed SpriteEquip node to HandEquip even though I specified the class_name
		hand_equip = player.find_child("HandEquip")
		for button in grid_container.get_children():
			if(button is ItemButton):
				print(hand_equip)
				button.hand_equip = hand_equip
