extends RigidBody2D

const min_velocity = 300
const max_velocity = 600
const move = Vector2(0, 20)


func random_start_angle():
	var right_side = randi() % 2 == 0
	rotation = PI * randf_range(0.3, 0.8)
	if right_side:
		rotation += PI
		
	linear_velocity = Vector2(0, min_velocity).rotated(rotation)


#func clamp_velocity():
	#


func _ready() -> void:
	random_start_angle()


func _physics_process(delta: float) -> void:
	linear_velocity = linear_velocity.clamp(Vector2(-max_velocity, -max_velocity), Vector2(max_velocity, max_velocity))
	add_constant_force(move.rotated(rotation) * delta)
