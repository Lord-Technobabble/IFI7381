extends CharacterBody2D

const MAX_SPEED = 1000
const ACCELARATION = 100
const SLOW_DOWN = 50

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	var mouse_pos = get_viewport().get_mouse_position()
	look_at(mouse_pos)
	
	var movement_dir = Vector2.RIGHT.rotated(rotation)
	velocity += movement_dir * ACCELARATION * delta
	move_and_slide()
