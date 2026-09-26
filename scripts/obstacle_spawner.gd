extends Path2D

@export var obstacle_scene: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_mob_spawn_timer_timeout() -> void:
	var obstacle = obstacle_scene.instantiate()
	
	var obstacle_loc = $ObstacleSpawnLocation
	obstacle_loc.progress_ratio = randf()
	obstacle.position = obstacle_loc.position
	
	var direction =  obstacle_loc.rotation + PI / 2
	obstacle.rotation = direction
	
	add_child(obstacle)
