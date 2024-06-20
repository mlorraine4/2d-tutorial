extends CharacterBody2D
enum MovementModes {
	IDLE,
	WALK
}

@export var inventory : Inventory

#@export makes variable visible to inspector
@export var move_speed : float = 100

@onready var animation_tree = $AnimationTree
@onready var animation_mode = animation_tree.get("parameters/playback")

var direction : Vector2 = Vector2.ZERO
var movement_mode : MovementModes = MovementModes.IDLE



func _ready():
	animation_tree.active = true

#Runs everytime character moves, (for moving and animating stuff, use process for everything else)
func _physics_process(_delta):
	#Get input direction, normalized makes sure diagonal movements move at same speed as other directions
	direction = Input.get_vector("left", "right", "up", "down").normalized()
	
	#Set velocity (characterbody already has a velocity var)

	if direction:
		set_velocity(direction * move_speed)
	else:
		set_velocity(Vector2.ZERO)
	
	# Move and Slide function uses velocity of character body to move character on map
	move_and_slide()
	
	update_animation_parameters()
	
func update_animation_parameters():
	var real_velocity = get_real_velocity()
	if real_velocity.length()/move_speed < .07:
		real_velocity = Vector2.ZERO
	
	#determine if player is idle, walking, or pressed swing
	if real_velocity == Vector2.ZERO:
		movement_mode = MovementModes.IDLE
	else:
		movement_mode = MovementModes.WALK

	if(velocity != Vector2.ZERO):
		#if character moves, update direction for each animation
		animation_tree["parameters/Swing/blend_position"] = velocity
		animation_tree["parameters/Idle/blend_position"] = velocity
		animation_tree["parameters/Walk/blend_position"] = velocity	

	animation_tree.set("parameters/conditions/swing", Input.is_action_just_pressed("use"))
	
	if Input.is_action_just_pressed("use"):
		pass
