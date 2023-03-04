extends CharacterBody3D

class_name movimiento

@onready var spring = $"../CharacterBody3D/MeshInstance3D/SpringArm"


var SPEED = 10
var  speedz = 200

const JUMP_VELOCITY = 4.5

var jump_cooldown :bool = false
var jump_count :int = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	#handle jump and start count
	if  is_on_floor() and Input.is_action_just_pressed("ui_up"):
		_jump()
	
	elif not is_on_floor() && Input.is_action_just_pressed("ui_up"):
		_double_jump()

	movement()
	
	#rotates the character around the spring arm
	# y axis
	velocity = velocity.rotated(Vector3.UP,spring.rotation.y)
	
	move_and_slide()
	
	# turns the springarm position the same as the character position 
	# or translation
	spring.position = position

func movement():
	var input_dir = Input.get_vector("izquierda", "derecha", "forward", "detras")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED 
		velocity.z = direction.z * SPEED 
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED) 

func _jump():
	#handle jump and start count
		if jump_cooldown == false:
			velocity.y = JUMP_VELOCITY
			jump_count = 1


func _double_jump():
		if jump_count == 1:
			velocity.y = JUMP_VELOCITY  + 4 
			jump_count = 2
			jump_cooldown = false

