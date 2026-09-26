extends Node2D

var started = false
var ended = false

var score = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"Texts/Score Display".text = "Score: %03d" % score
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
	
	$Texts/StartText.visible = false
	
	$ObstacleSpawner/MobSpawnTimer.start()
	
	$ScoreTimer.start()
	
func game_over():
	$Texts/GameOver.visible = true
	ended = true
	
	$ScoreTimer.stop()
	$BackgroundMusic.stop()


func _on_score_timer_timeout() -> void:
	score += 1
	$"Texts/Score Display".text = "Score: %03d" % score
