extends Control

var is_open = false

# Called when the node enters the scene tree for the first time.
func _ready():
	close()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("inventory"):
		toggle()
		
func toggle():
	if is_open:
		close()
	else:
		open()

func open():
	$ColorRect.visible = false
	$Window.visible = true
	is_open = true

func close():
	$ColorRect.visible = true
	$Window.visible = false
	is_open = false
