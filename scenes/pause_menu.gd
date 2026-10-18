extends HBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	focus_start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	visible = get_tree().paused


func focus_start():
	$BasicMenu/ButtonContainer/Margins/Buttons/Start.grab_focus()


func _on_visibility_changed() -> void:
	if visible:
		focus_start()
