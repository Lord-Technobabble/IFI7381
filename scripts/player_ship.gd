extends CharacterBody2D

const ACCELARATION = 550
const SLOW_DOWN = 150

signal died

var is_dead = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	$ThrusterFlame.visible = false
	var mouse_pos = get_viewport().get_mouse_position()
	
	slow_down(delta)
	
	if !is_dead:
		look_at(mouse_pos)
		if Input.is_action_pressed("fire_thrusters"):
			fire_thrusters(delta)
			
			# Dont think this is the best way to do it, but its the one I got
			if !$ThrusterSound.playing:
				$ThrusterSound.play()
		else:
			$ThrusterSound.stop()
	
	var collided = move_and_slide()
	if collided:
		die()
	
	

func slow_down(delta):
	var size_limited = min(velocity.length(), 1)
	
	#This should overshoot 0 only if delta is greater then 1
	velocity -= velocity.normalized() * SLOW_DOWN * delta * size_limited
	
func fire_thrusters(delta):
	var movement_dir = Vector2.RIGHT.rotated(rotation)
	velocity += movement_dir * ACCELARATION * delta
	$ThrusterFlame.visible = true

func die():
	is_dead = true
	$DamageSprite.visible = true
	$ThrusterSound.stop()
	emit_signal("died")
