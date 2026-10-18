extends Node2D

var started = false
var ended = false

var score = 0

signal score_changed(score: int)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("fire_thrusters"):
		start()
		
	if Input.is_action_just_pressed("fire_thrusters"):
		if ended:
			get_tree().reload_current_scene()

func _on_player_ship_died() -> void:
	game_over()

func start() -> void:
	if started:
		return
	started = true
	
	$ObstacleSpawner/MobSpawnTimer.start()
	
	$ScoreTimer.start()
	
func game_over():
	$Texts/GameOver.visible = true
	ended = true
	
	$ScoreTimer.stop()
	$BackgroundMusic.stop()


func _on_score_timer_timeout() -> void:
	score += 1
	emit_signal("score_changed", score)

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			get_tree().paused = true
