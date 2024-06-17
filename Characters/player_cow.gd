extends CharacterBody2D

enum COW_STATE { IDLE, WALK }

@export var move_speed: float = 20
@export var idle_time: float = 5
@export var walk_time: float = 2

@onready var timer = $Timer
@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var sprite = $Sprite2D

var move_direction : Vector2 = Vector2.ZERO
var current_state : COW_STATE = COW_STATE.IDLE

func _ready():
	select_new_direction()
	#cow state defaults to idle, set to walking
	pick_new_state()

func _physics_process(_delta):
	if (current_state == COW_STATE.WALK):
		velocity = move_direction * move_speed
	
		move_and_slide()

#Get random direction, set new move direction (can be -1, 1, or 0 for x and y)
func select_new_direction():
	move_direction = Vector2(randi_range(-1, 1), randi_range(-1, 1))
	
	if (move_direction.x < 0):
		#sprite's default is facing right, flip to walk left
		sprite.flip_h = true
	elif(move_direction.x > 0):
		#keep default sprite direction
		sprite.flip_h = false
	

#Switch from walking to idling
func pick_new_state():
	if(current_state == COW_STATE.IDLE):
		#change to "walk_right" animation
		state_machine.travel("walk_right")
		#save state
		current_state = COW_STATE.WALK
		#pick a different direction
		select_new_direction()
		#begin walking timer
		timer.start(walk_time)
	elif(current_state == COW_STATE.WALK):
		#change to "idle_right" animation
		state_machine.travel("idle_right")
		current_state = COW_STATE.IDLE
		timer.start(idle_time)

#added from Timer node
func _on_timer_timeout():
	pick_new_state()
