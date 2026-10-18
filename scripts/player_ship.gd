extends CharacterBody2D

const ACCELARATION = 2000
const SLOW_DOWN = 150
const MAX_THRUST_TIME: float = 1 #seconds
const RECHARGE_TIME: float = 0.5

signal died
signal thrust_time_changed(frac: float)

var is_dead = false
var remaining_thrust_time: float = MAX_THRUST_TIME

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	var previous_tt = remaining_thrust_time
	
	$ThrusterFlame.visible = false
	var mouse_pos = get_viewport().get_mouse_position()
	
	slow_down(delta)
	
	if !is_dead:
		look_at(mouse_pos)
		var can_fire = false
		if Input.is_action_pressed("fire_thrusters"):
			can_fire = remaining_thrust_time > 0
		else:
			remaining_thrust_time = min(MAX_THRUST_TIME, remaining_thrust_time + delta / RECHARGE_TIME)

		if can_fire:
			fire_thrusters(delta)
			
			# Dont think this is the best way to do it, but its the one I got
			if !$ThrusterSound.playing:
				$ThrusterSound.play()
		else:
			$ThrusterSound.stop()
		
		if previous_tt != remaining_thrust_time:
			emit_signal("thrust_time_changed", get_thrust_time_frac())
	
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
	remaining_thrust_time = max(0, remaining_thrust_time - delta)

func die():
	is_dead = true
	$DamageSprite.visible = true
	$ThrusterSound.stop()
	emit_signal("died")

func get_thrust_time_frac():
	return remaining_thrust_time / MAX_THRUST_TIME
