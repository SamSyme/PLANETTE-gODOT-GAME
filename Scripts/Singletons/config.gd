# holds all game constants in one place
extends Node

# ===== COLLISION LAYERS =====

# These numbers are powers of 2 (binary layers)
const LAYER_PLANET = 1      # Layer 1
const LAYER_PLAYER = 2      # Layer 2  
const LAYER_HAZARDS = 4     # Layer 3
const LAYER_METEORS = 8     # Layer 4

# ===== PLANET SETTINGS =====
const BASE_PLANET_RADIUS = 5.0
const MIN_PLANET_RADIUS = 2.0
const SHRINK_RATE = 0.05  # How fast planet shrinks per second

# ===== PLAYER SETTINGS =====
const PLAYER_SPEED = 10.0
const TURN_SPEED = 2.0
const TURN_COOLDOWN = 1.0  # Seconds between turns

# ===== SPAWNING SETTINGS =====
const OBSTACLE_SPAWN_INTERVAL = 1.5  # Seconds between obstacle spawns
const METEOR_SPAWN_INTERVAL = 1.0    # Seconds between meteor spawns
const METEOR_SPAWN_DISTANCE = 15.0   # How far above planet meteors spawn

# ===== METEOR SETTINGS =====
const METEOR_FALL_SPEED = 5.0
const METEOR_DESTROY_DISTANCE = 1.5

# ===== SCORING =====
const POINTS_PER_SECOND = 10
