extends CharacterBody3D

const SPEED = 3.0
const SENSITIVITY = 0.003

var gravity = 9.8
@export var camera : Camera3D
@export var head : Node3D

@export var bob_freq : float = 2.4
@export var bob_amp : float = 0.03
var t_bob : float = 0.0

@export var seetext : Label
@onready var seecast := %SeeCast

@onready var footstep_player = $FootStepsPlayer
var footstep_timer : float = 0.0
const FOOTSTEP_INTERVAL : float = 0.7

signal clicked
@export var cursor : Resource

func _ready():
	#Input.set_custom_mouse_cursor(cursor)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-40), deg_to_rad(60))


func _physics_process(delta: float) -> void:
	
	if !is_inside_tree(): return
	
	if is_instance_valid(seecast) and seecast.is_colliding():
		var target = seecast.get_collider()
		#print(target)
		if target != null and target.is_in_group("Interactables"): # OR MAKE A GROUP!
			seetext.show()
			#print("can see tutorial message!")
			if Input.is_action_just_pressed("interact"):
				clicked.emit(target.get_parent())
				print("DO STUFF!")
		else: seetext.hide()
	
	
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	var input_dir = Input.get_vector("3D_left","3D_right", "3D_up", "3D_down")
	var direction = (head.transform.basis * Vector3(
		input_dir.x,0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = 0.0
		velocity.z = 0.0
	
	#for head bob:
	t_bob += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = _headbob(t_bob)
	
	move_and_slide()
	if is_on_floor() and velocity.length() > 0.1:
		footstep_timer -= delta
		if footstep_timer <= 0.0:
			footstep_player.play()
			footstep_timer = FOOTSTEP_INTERVAL
	else:
		footstep_timer = 0.0


func _headbob(time : float) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * bob_freq) * bob_amp
	pos.x = cos(time * bob_freq /2) * bob_amp
	return pos
