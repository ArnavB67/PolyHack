extends Node2D

var RandomCharacters= ["0","1","A","Z","$","#","X","%","!","?"]
var RainText=""
var RainTextLength
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	RainTextLength= randi_range(1,5)
	for i in range(RainTextLength):
		RainText+=RandomCharacters.pick_random()+"\n"
	$Label.text=RainText

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y+=350*delta
	if position.y > get_viewport_rect().size.y + 200:
		queue_free()
	
