extends CharacterBody2D

const acceleration = 70
const max_acceleration = 800
const decceleration = 40


func get_input():
	var up = Input.is_action_pressed("move_up")
	var down = Input.is_action_pressed("move_down")
		
	if up:
		velocity.y -= acceleration
	if down:
		velocity.y += acceleration
		
	velocity = velocity.clamp(Vector2(0, -max_acceleration), Vector2(0, max_acceleration))


func deccelerate():
	if velocity.y > 0:
		velocity.y -= decceleration
		if velocity.y <= 0:
			velocity.y = 0
		
	if velocity.y < 0:
		velocity.y += decceleration
		if velocity.y >= 0:
			velocity.y = 0


func _physics_process(delta: float) -> void:
	get_input()
	
	var bounds_hit
	var collision_info = move_and_collide(velocity * delta)
	if collision_info != null:
		bounds_hit = true
	if bounds_hit:
		velocity.y = 0
	
	deccelerate()
