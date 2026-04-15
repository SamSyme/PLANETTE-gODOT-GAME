extends CharacterBody3D

@export var move_speed: float = Config.PLAYER_SPEED
@export var turn_speed: float = 2.0
@export var sphere_center: Node3D
@export var sphere_radius: float = 0.5
@export var spawn_point: Node3D

@export var camera: Camera3D

@export var max_hp: int = 3
var hp: int
var is_dead: bool = false

func _ready() -> void:
	hp = max_hp
	is_dead = false

	Events.request_respawn.connect(respawn)
	Events.player_spawned.emit()

func _physics_process(delta: float) -> void:
	if is_dead:
		return

	var up_dir = (global_position - sphere_center.global_position).normalized()
	global_position = sphere_center.global_position + up_dir * sphere_radius

	var forward = -transform.basis.z.normalized()
	var right = up_dir.cross(forward).normalized()
	forward = right.cross(up_dir).normalized()
	transform.basis = Basis(right, up_dir, -forward)

	var turn_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if turn_input != 0:
		forward = forward.rotated(up_dir, -turn_input * turn_speed * delta)

	right = up_dir.cross(forward).normalized()
	forward = right.cross(up_dir).normalized()
	transform.basis = Basis(right, up_dir, -forward)

	velocity = forward * move_speed
	move_and_slide()

func take_damage(amount: int):
	if is_dead:
		return

	hp -= amount
	print("HP:", hp)
	
	if camera:
		camera.shake()

	Events.emit_signal("player_hit", hp)

	if hp <= 0:
		die()

func die():
	print("Player died")
	is_dead = true
	
	visible = false
	velocity = Vector3.ZERO
	set_physics_process(false)
	
	if camera:
		camera.freeze()

	Events.player_died.emit()

func respawn():
	print("RESPAWN")

	is_dead = false
	hp = max_hp
	visible = true
	velocity = Vector3.ZERO
	
	if spawn_point:
		global_transform = spawn_point.global_transform

	set_physics_process(true)
	
	if camera:
		camera.unfreeze()
		
	Events.player_spawned.emit()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		if GameManager.current_state in [
			GameManager.GameState.MENU,
			GameManager.GameState.GAME_OVER
		]:
			GameManager.start_game()
