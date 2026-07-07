extends CharacterBody2D


const SPEED = 300.0
const RotationSpeed = 15

func _physics_process(delta: float) -> void:
	var Direction = Input.get_vector("Left","Right","Up","Down")
	velocity = Direction*SPEED
	if Direction.length()>0:
		rotation = lerp_angle(rotation,Direction.angle(),RotationSpeed*delta)
	move_and_slide()
