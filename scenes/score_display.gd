extends Label

const DISPLAY_FORMAT = "Score: %3d"
var score = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = DISPLAY_FORMAT % score


func _on_game_score_changed(new_score: int) -> void:
	score = new_score
