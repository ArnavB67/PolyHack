extends Node

const ENEMY = preload("uid://ffuginxsakpn")
var GameOverTriggered = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$GameOverLayer.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Globals.IsGameOver == true and not GameOverTriggered:
		GameOverTriggered=true
		$GameOverLayer/GameOverPanel.scale = Vector2(0,0.02)
		$GameOverLayer.show()
		var PopupTween=get_tree().create_tween()
		PopupTween.tween_property($GameOverLayer/GameOverPanel,"scale",Vector2(1,0.02),0.2)
		PopupTween.tween_property($GameOverLayer/GameOverPanel,"scale",Vector2(1,1),0.2)
		$EnemySpawnTimer.stop()
		var Enemies = get_tree().get_nodes_in_group("Enemy")
		for Enemy in Enemies:
			Enemy.queue_free()


func _on_enemy_spawn_timer_timeout() -> void:
	var Enemy = ENEMY.instantiate()
	Enemy.position=Vector2(randi_range(-5,1158),randi_range(-5,680))
	get_tree().current_scene.add_child(Enemy)


func _on_restart_pressed() -> void:
	Globals.Reset()
	get_tree().reload_current_scene()
