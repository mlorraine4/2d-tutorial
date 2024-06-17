extends CharacterBody2D
#@export makes variable visible to inspector
@export var move_speed : float = 100

@onready var animation_tree = $AnimationTree

var direction : Vector2 = Vector2.ZERO

func _ready():
	animation_tree.active = true

#Runs everytime character moves, (for moving and animating stuff, use process for everything else)
func _physics_process(_delta):
	#Get input direction, normalized makes sure diagonal movements move at same speed as other directions
	direction = Input.get_vector("left", "right", "up", "down").normalized()
	
	#Set velocity (characterbody already has a velocity var)
	if direction:
		velocity = direction * move_speed
	else:
		velocity = Vector2.ZERO
	
	# Move and Slide function uses velocity of character body to move character on map
	move_and_slide()
	
	update_animation_parameters()
	
func update_animation_parameters():
	#determine if player is idle, walking, or pressed swing
	animation_tree.set("parameters/conditions/idle", velocity == Vector2.ZERO)
	animation_tree.set("parameters/conditions/walk", velocity != Vector2.ZERO)
	animation_tree.set("parameters/conditions/swing", Input.is_action_just_pressed("use"))
	
	if(direction != Vector2.ZERO):
		#if character moves, update direction for each animation
		animation_tree["parameters/Swing/blend_position"] = direction
		animation_tree["parameters/Idle/blend_position"] = direction
		animation_tree["parameters/Walk/blend_position"] = direction
	

