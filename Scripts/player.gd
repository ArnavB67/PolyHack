extends CharacterBody2D


const SPEED = 300.0
const RotationSpeed = 15
@onready var health_bar: ProgressBar = $CanvasLayer/HealthBar
@onready var trail: Line2D = $Trail
const SHOCKWAVE = preload("uid://cenqfmvdq47s8")
const BULLET = preload("uid://n4emwbh4t78o")
var OnShockwaveCooldown= false
var OnBulletCooldown= false

func _ready() -> void:
	add_to_group("Player")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("EscapeMenu"):
		%GameOverLayer.visible= not %GameOverLayer.visible
		if Engine.time_scale!=0:
			Engine.time_scale=0
		else:
			Engine.time_scale=1
	
	$CanvasLayer/ShockWaveCooldown/ShockwaveProgressBar.value= $ShockwaveCooldown.time_left
	$CanvasLayer/BulletCooldown/BulletCooldownProgressBar.value= $BulletTimer.time_left
	trail.add_point(global_position)
	if trail.get_point_count()>15:
		trail.remove_point(0)
	Globals.PlayerPosition = global_position
	health_bar.value = Globals.HackPercentage
	$CanvasLayer/HealthBar/Label.text= str(Globals.HackPercentage)+"% HACKED"
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
	if Input.is_action_just_pressed("Shockwave") and not OnShockwaveCooldown:
		OnShockwaveCooldown=true
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
		$ShockwaveCooldown.start()
		
	if Input.is_action_just_pressed("Shoot") and not OnBulletCooldown:
		OnBulletCooldown =true
		look_at(get_global_mouse_position())
		var Bullet= BULLET.instantiate()
		Bullet.global_position= global_position
		Bullet.rotation = rotation
		get_tree().current_scene.add_child(Bullet)
		$BulletTimer.start()
		
		
		

func _physics_process(delta: float) -> void:
	var Direction = Input.get_vector("Left","Right","Up","Down")
	velocity = Direction*SPEED
	if Direction.length()>0:
		rotation = lerp_angle(rotation,Direction.angle(),RotationSpeed*delta)
	move_and_slide()


func _on_shockwave_cooldown_timeout() -> void:
	OnShockwaveCooldown= false


func _on_bullet_timer_timeout() -> void:
	OnBulletCooldown= false
