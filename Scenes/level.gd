extends Node

const ENEMY = preload("uid://ffuginxsakpn")
var GameOverTriggered = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%GameOverLayer.visible=false
	Engine.time_scale=1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$LevelUI/Score.text = "PURGED : "+str(Globals.Score)
	$GameOverLayer/GameOverPanel/Label2.text=str(Globals.Score)+" THREATS NULLIFIED"
	var CurrentEnemySpawnTimer= max(0.25,1.5-(Globals.Score*0.01))
	$EnemySpawnTimer.wait_time= CurrentEnemySpawnTimer
	if Globals.IsGameOver == true and not GameOverTriggered:
		GameOverTriggered=true
		$GameOverLayer/GameOverPanel.scale = Vector2(0,0.02)
		%GameOverLayer.visible=true
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


func _on_home_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	Engine.time_scale=1
