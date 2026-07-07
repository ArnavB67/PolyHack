extends CharacterBody2D


const SPEED = 300.0
const RotationSpeed = 15
@onready var health_bar: ProgressBar = $CanvasLayer/HealthBar

func _ready() -> void:
	add_to_group("Player")

func _process(delta: float) -> void:
	Globals.PlayerPosition = global_position
	health_bar.value = Globals.HackPercentage
	if Globals.IsGameOver == true:
		queue_free()

func _physics_process(delta: float) -> void:
	var Direction = Input.get_vector("Left","Right","Up","Down")
	velocity = Direction*SPEED
	if Direction.length()>0:
		rotation = lerp_angle(rotation,Direction.angle(),RotationSpeed*delta)
	move_and_slide()
