extends RigidBody2D

const MAX_ROTATION_RPS = 10

const MIN_SPEED = 100
const MAX_SPEED = 500

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	angular_velocity = (randf() - 0.5) * 2 * MAX_ROTATION_RPS
	
	var speed = MIN_SPEED + (randi() % (MAX_SPEED - MIN_SPEED))
	linear_velocity = Vector2(speed, 0).rotated(rotation)
# Called every frame. 'delta' is the elapsed time since the previous frame.


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_body_entered(body: Node) -> void:
	print("collided")
	if body.has_method("die"):
		body.die()
