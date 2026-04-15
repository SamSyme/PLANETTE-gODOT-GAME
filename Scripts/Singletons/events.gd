# THis is central place for game-wide events
extends Node

# ===== GAME FLOW EVENTS =====
signal game_started
signal game_over(final_score: int)
signal game_paused
signal game_resumed
signal request_respawn

# ===== SCORE EVENTS =====
signal score_changed(new_score: int)

# ===== PLAYER EVENTS =====
signal player_died
signal player_hit
signal player_spawned
signal player_turned(direction: float)  # -1 for left, 1 for right

# ===== HAZARD EVENTS =====
signal meteor_spawned(meteor: Node3D)
signal meteor_destroyed(position: Vector3)
signal mine_spawned(mine: Node3D)
signal obstacle_destroyed(obstacle: Node3D)

# ===== PLANET EVENTS =====
signal planet_shrunk(new_radius: float, old_radius: float)
signal planet_critical(current_radius: float)  # When planet is dangerously small
