extends Camera3D

@export var target_path: NodePath
@export var height: float = 10.0
@export var smoothness: float = 9.0

# ===== CINEMATIC INTRO =====
@export var intro_smoothness: float = 2.0
@export var intro_hold_time: float = 2.0
@export var intro_lerp_speed: float = 1.5

var _current_smoothness: float
var _intro_timer: float = 0.0

# ===== CAMERA TARGET =====
var target: Node3D
var frozen: bool = false

# ===== HIT SHAKE =====
@export var hit_shake_strength: float = 0.25
@export var hit_shake_duration: float = 0.15

var shake_time: float = 0.0
var shake_strength: float = 0.0


func _ready() -> void:
	if target_path != NodePath():
		target = get_node(target_path) as Node3D
		print("Camera target set:", target.name)

	_current_smoothness = smoothness
	print("Camera ready")

	Events.game_started.connect(_on_game_started)


func _physics_process(delta: float) -> void:
	if not target or frozen:
		return

	# ===== CINEMATIC INTRO LOGIC =====
	if _intro_timer > 0.0:
		_intro_timer -= delta
	else:
		_current_smoothness = lerp(
			_current_smoothness,
			smoothness,
			intro_lerp_speed * delta
		)

	# ===== CAMERA POSITION =====
	var up_dir = target.global_position.normalized()
	var desired_position = target.global_position + up_dir * height

	global_position = global_position.lerp(
		desired_position,
		_current_smoothness * delta
	)

	# ===== LOOK AT PLANET CENTER =====
	look_at(Vector3.ZERO, up_dir)

	# ===== CAMERA SHAKE =====
	if shake_time > 0.0:
		shake_time -= delta
		var shake_offset = Vector3(
			randf_range(-1.0, 1.0),
			randf_range(-1.0, 1.0),
			randf_range(-1.0, 1.0)
		) * shake_strength
		global_position += shake_offset


# ===== CAMERA CONTROL =====

func freeze() -> void:
	frozen = true


func unfreeze() -> void:
	frozen = false
	if target:
		var up_dir = target.global_position.normalized()
		global_position = target.global_position + up_dir * height
		look_at(Vector3.ZERO, up_dir)


func shake() -> void:
	shake_strength = hit_shake_strength
	shake_time = hit_shake_duration


# ===== EVENTS =====

func _on_game_started() -> void:
	print("CAMERA INTRO START")
	_current_smoothness = intro_smoothness
	_intro_timer = intro_hold_time
