extends Node

const TRIANGLE_ENEMY = preload("uid://ffuginxsakpn")
const SQUARE_ENEMY = preload("uid://b0b7byu7bpff6")
var GameOverTriggered = false
var LastTimeHealedScore =0
var IsWarningActive = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%GameOverLayer.visible=false
	Engine.time_scale=1
	Input.set_custom_mouse_cursor(preload("res://Assets/crosshair.png"),Input.CURSOR_ARROW,Vector2(16,16))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Globals.Score%5 ==0 and LastTimeHealedScore!=Globals.Score and Globals.HackPercentage-1>0:
		LastTimeHealedScore=Globals.Score
		Globals.HackPercentage-=1
		var HealTween = get_tree().create_tween()
		HealTween.tween_property($HealBG.get_theme_stylebox("panel"),"bg_color:a",0.1,0.2)
		HealTween.tween_property($HealBG.get_theme_stylebox("panel"),"bg_color:a",0,0.2)
	elif Globals.HackPercentage>=90 and not IsWarningActive:
		IsWarningActive=true
		var WarningTween = get_tree().create_tween().set_loops()
		WarningTween.tween_property($WarningBG.get_theme_stylebox("panel"),"bg_color:a",0.1,0.2)
		WarningTween.tween_property($WarningBG.get_theme_stylebox("panel"),"bg_color:a",0,0.2)
	elif Globals.HackPercentage<90:
		IsWarningActive=false
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
	if Globals.Score>25 and randf()>0.6:
		var SquareEnemy = SQUARE_ENEMY.instantiate()
		SquareEnemy.position=Vector2(randi_range(-5,1158),randi_range(-5,680))
		get_tree().current_scene.add_child(SquareEnemy)
	else:
		var TriangleEnemy = TRIANGLE_ENEMY.instantiate()
		TriangleEnemy.position=Vector2(randi_range(-5,1158),randi_range(-5,680))
		get_tree().current_scene.add_child(TriangleEnemy)


func _on_restart_pressed() -> void:
	Globals.Reset()
	get_tree().reload_current_scene()


func _on_home_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	Engine.time_scale=1
