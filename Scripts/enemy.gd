extends Area2D

var Direction
const EnemySpeed= 200
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("Enemy")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	Direction = (Globals.PlayerPosition-global_position).normalized()
	position.x+=Direction.x*delta*EnemySpeed
	position.y+=Direction.y*delta*EnemySpeed
	rotation=lerp_angle(rotation,Direction.angle(),15*delta)

func _on_life_time_timeout() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if Globals.HackPercentage+5<100:
			Globals.HackPercentage+=5
			Globals.IsPlayerHit = true
		elif Globals.HackPercentage<=100:
			Globals.HackPercentage=100
			Globals.IsGameOver = true
		queue_free()

func TakeDamage():
	$DeathEffect.emitting=true
	$Polygon2D.hide()
	$CollisionPolygon2D.set_deferred("disabled",true)
	var Camera=get_viewport().get_camera_2d()
	if Camera:
		Camera.ShakeOnHit(15)
	await get_tree().create_timer(0.3).timeout
	queue_free()
	
