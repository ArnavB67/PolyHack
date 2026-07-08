extends CharacterBody2D


const SPEED = 300.0
const RotationSpeed = 15
@onready var health_bar: ProgressBar = $CanvasLayer/HealthBar
@onready var trail: Line2D = $Trail
const SHOCKWAVE = preload("uid://cenqfmvdq47s8")
const BULLET = preload("uid://n4emwbh4t78o")

func _ready() -> void:
	add_to_group("Player")

func _process(delta: float) -> void:
	trail.add_point(global_position)
	if trail.get_point_count()>15:
		trail.remove_point(0)
	Globals.PlayerPosition = global_position
	health_bar.value = Globals.HackPercentage
	if Globals.IsGameOver == true:
		hide()
		$"../LevelUI/GlitchEffect".visible=true
	if Globals.IsPlayerHit:
		Globals.IsPlayerHit= false
		$DamageEffect.emitting = true
		var Camera=get_viewport().get_camera_2d()
		if Camera:
			Camera.ShakeOnHit(25)
		$"../LevelUI/GlitchEffect".visible=true
		await get_tree().create_timer(0.15).timeout
		$"../LevelUI/GlitchEffect".visible=false
	if Input.is_action_just_pressed("Shockwave"):
		print("Clicked")
		var Shockwave= SHOCKWAVE.instantiate()
		Shockwave.scale= scale
		Shockwave.rotation =rotation
		Shockwave.global_position=global_position
		set_physics_process(false)
		get_tree().current_scene.add_child(Shockwave)
		var ShockwaveScaleTween = get_tree().create_tween()
		ShockwaveScaleTween.tween_property(Shockwave,"scale",Shockwave.scale*8,0.5)
		await get_tree().create_timer(0.5).timeout
		set_physics_process(true)
	if Input.is_action_just_pressed("Shoot"):
		look_at(get_global_mouse_position())
		var Bullet= BULLET.instantiate()
		Bullet.global_position= global_position
		Bullet.rotation = rotation
		get_tree().current_scene.add_child(Bullet)
		
		
		

func _physics_process(delta: float) -> void:
	var Direction = Input.get_vector("Left","Right","Up","Down")
	velocity = Direction*SPEED
	if Direction.length()>0:
		rotation = lerp_angle(rotation,Direction.angle(),RotationSpeed*delta)
	move_and_slide()
