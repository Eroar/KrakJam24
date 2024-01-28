extends Node3D

@export var SCORE:int = 0
var letter = preload("res://letter/Letter.tscn")

func _make_it_rain():
	for i in range(30):
		var new_letter = letter.instantiate()
		new_letter.position = Vector3(randf_range(-10, 10), 20, randf_range(-7, 7))
		new_letter.angular_velocity = Vector3(randf_range(0, 10), randf_range(0, 10), randf_range(0, 10))
		add_child.call_deferred(new_letter)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$Label3D.text = str(SCORE) + " LAT DLA POCZTY PLOSKIEJ!"
