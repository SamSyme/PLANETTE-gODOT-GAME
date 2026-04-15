extends CharacterBody3D

@export var fall_speed: float = 5.0
@export var destroy_distance: float = 1.5
@export var mine_scene: PackedScene
@export var planet_path: NodePath

var planet: Node3D

func _ready() -> void:
	if planet_path != NodePath():
		planet = get_node(planet_path) as Node3D

func _physics_process(delta: float) -> void:
	if not planet:
		return
	
	var to_center = -global_position.normalized()
	self.velocity = to_center * fall_speed
	move_and_slide()
	
	#If planet is not perfectly centered at 0,0,0, this becomes wrong.
	var distance_to_center = global_position.length() # not the planet’s radius,it’s distance from world origin.
	var planet_radius = planet.global_position.length()
	
	if distance_to_center <= planet_radius + destroy_distance:
		spawn_mine()
		queue_free()
		print("meteor desstroyed")

func spawn_mine():
	if mine_scene:
		var mine_instance = mine_scene.instantiate()
		get_tree().current_scene.add_child(mine_instance)
		mine_instance.global_transform.origin = global_transform.origin

func _on_impact_area_body_entered(body: Node3D) -> void:
	if body == self or body.is_in_group("meteor"):
		return
	print("Collision detected with:", body.name)
	spawn_mine()
	queue_free()
