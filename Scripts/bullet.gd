extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position+=Vector2(cos(rotation),sin(rotation))*400*delta


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		area.TakeDamage()
