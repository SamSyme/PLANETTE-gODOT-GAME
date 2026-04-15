extends Node

enum GameState {
	MENU,
	PLAYING,
	PAUSED,
	GAME_OVER
}

var current_state: GameState = GameState.MENU

var current_score: int = 0
var high_score: int = 0
var time_survived: float = 0.0

var planet: Node3D = null
var difficulty_multiplier: float = 1.0

func _ready() -> void:
	Events.player_died.connect(_on_player_died)

func _physics_process(delta: float) -> void:
	if current_state != GameState.PLAYING:
		return

	time_survived += delta
	var score_to_add = int(delta * Config.POINTS_PER_SECOND)
	if score_to_add > 0:
		add_score(score_to_add)

	difficulty_multiplier = 1.0 + (time_survived / 10.0) * 0.1

func start_game() -> void:
	current_state = GameState.PLAYING
	current_score = 0
	time_survived = 0.0
	difficulty_multiplier = 1.0
	
	clear_obstacles()

	if planet:
		planet.reset_planet()

	print("Game started!")
	Events.request_respawn.emit()
	Events.game_started.emit()

func end_game() -> void:
	if current_state == GameState.GAME_OVER:
		return

	current_state = GameState.GAME_OVER

	if current_score > high_score:
		high_score = current_score
		print("New high score:", high_score)

	print("Game over! Final score:", current_score)
	Events.game_over.emit(current_score)

func _on_player_died():
	end_game()

func add_score(points: int) -> void:
	current_score += points
	Events.score_changed.emit(current_score)

func is_playing() -> bool:
	return current_state == GameState.PLAYING
	
func clear_obstacles():
	var obstacles = get_tree().get_nodes_in_group("obstacles")
	
	for obstacle in obstacles:
		obstacle.queue_free()
	print("Cleared: ", obstacles.size(), " obstacles")
