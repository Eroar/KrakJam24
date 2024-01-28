extends Path3D

@onready var game = get_parent().get_parent()

var t = 0.0
# Called when the node enters the scene tree for the first time.
func _ready():
	game.addScore($PathFollow3D.get_child(0).POINT_VALUE)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	t += delta
	$PathFollow3D.progress = 2.0 * t
	if $PathFollow3D.progress == 4:
		queue_free()
