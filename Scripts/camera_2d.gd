extends Camera2D

var ShakeIntensity = 0

func _process(delta: float) -> void:
	if ShakeIntensity>0:
		offset= Vector2(randf_range(-1,1),randf_range(-1,1))*ShakeIntensity
		ShakeIntensity=lerpf(ShakeIntensity,0,10*delta)
	else:
		offset=Vector2.ZERO

func ShakeOnHit(Intensity):
	ShakeIntensity = Intensity
