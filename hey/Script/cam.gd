extends SpringArm3D

var mouse_sensitivity :float = 10

@onready var camera = $Camera

func _ready():
	
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotation_degrees.x -= event.relative.y * 0.15 
		rotation_degrees.x = clampf(rotation_degrees.x,-40,5)
		
		rotation_degrees.y -= event.relative.x * 0.15
		rotation_degrees.y = wrapf(rotation_degrees.y,0,300)
		
	_ZOOM()
	
func _ZOOM():
	
	if Input.is_action_just_pressed("zoom"):
			camera.fov -= 10
	elif Input.is_action_just_pressed("zoom_atras"):
			camera.fov += 20
		
