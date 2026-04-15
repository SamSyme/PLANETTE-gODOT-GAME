extends Node3D

@export var obstacle_scene: PackedScene
@export var mine_scene: PackedScene
@export var meteor_scene: PackedScene

@export var planet_path: NodePath
@export var base_radius: float = 5.0  # Base radius before any scaling

@export var spawn_interval: float = 1.5
@export var spawn_meteor_interval: float = 1.0

var planet: Node3D
var obstacle_timer: float = 0.0
var meteor_timer: float = 0.0

func _ready() -> void:
	if planet_path != NodePath():
		planet = get_node(planet_path) as Node3D
	else:
		push_error("Planet path not set in SpawnManager.")

func _physics_process(delta: float) -> void:
	if not planet:
		return

	obstacle_timer -= delta
	if obstacle_timer <= 0:
		spawn_obstacle()
		obstacle_timer = spawn_interval
	
	meteor_timer -= delta
	if meteor_timer <= 0:
		spawn_meteor()
		meteor_timer = spawn_meteor_interval

func spawn_obstacle() -> void:
	if not is_inside_tree() or not planet:
		return

	# Get current scaled radius of the planet
	var scale_factor = planet.global_transform.basis.get_scale().x# assuming uniform scaling
	var current_radius = base_radius * scale_factor

	# Generate a random direction from the center
	var direction = Vector3(
		randf_range(-1.0, 1.0),
		randf_range(-1.0, 1.0),
		randf_range(-1.0, 1.0)
	).normalized()

	# Position on the surface
	var position = direction * current_radius

	# Create obstacle
	var obstacle = obstacle_scene.instantiate()
	obstacle.global_position = position
	obstacle.look_at(planet.global_position, direction)

	add_child(obstacle)

func spawn_meteor() -> void:
	if not is_inside_tree() or not meteor_scene:
		return
	
	var scale_factor = planet.global_transform.basis.get_scale().x
	var current_radius = base_radius * scale_factor
	
	var direction = Vector3(
		randf_range(-1.0, 1.0),
		randf_range(-1.0, 1.0),
		randf_range(-1.0, 1.0)
	).normalized()
	
	var spawn_distance = current_radius + 15.0
	var position = direction * spawn_distance
	
	var meteor = meteor_scene.instantiate()
	meteor.global_position = position
	
	meteor.planet_path = planet.get_path()
	meteor.mine_scene = mine_scene

	#get_tree().current_scene.add_child(meteor) <-- spawn in main scene
	get_parent().add_child(meteor) # <-- spawn in as child of spawn manager, hopefully.
