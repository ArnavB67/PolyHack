extends Control

const TEXT_RAIN = preload("uid://f3xi1xd8fgmx")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_custom_mouse_cursor(preload("res://Assets/crosshair.png"),Input.CURSOR_ARROW,Vector2(16,16))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_connect_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Level.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_rain_text_timer_timeout() -> void:
	var TextRain =TEXT_RAIN.instantiate()
	var RandomSpawnX= randi_range(0,get_viewport_rect().size.x)
	TextRain.position= Vector2(RandomSpawnX,-25)
	$BG.add_child(TextRain)
	
