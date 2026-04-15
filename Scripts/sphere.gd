extends StaticBody3D

@export var initial_radius: float = 5.0
var current_radius: float

func _ready() -> void:
	current_radius = initial_radius
	scale = Vector3.ONE

	GameManager.planet = self

	collision_layer = Config.LAYER_PLANET
	collision_mask = 0

	print("Planet initialized at radius:", current_radius)

func reset_planet():
	current_radius = initial_radius
	scale = Vector3.ONE
	print("Planet reset")

func get_radius() -> float:
	return current_radius

func get_surface_position(direction: Vector3) -> Vector3:
	return global_position + direction.normalized() * current_radius
