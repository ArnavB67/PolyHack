extends Node

const ENEMY = preload("uid://ffuginxsakpn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_enemy_spawn_timer_timeout() -> void:
	var Enemy = ENEMY.instantiate()
	Enemy.position=Vector2(randi_range(-5,1158),randi_range(-5,680))
	get_tree().current_scene.add_child(Enemy)
