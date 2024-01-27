extends Node3D

@export var SCORE = 0
var letter = preload("res://letter/Letter.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(60):
		var new_letter = letter.instantiate()
		new_letter.position = Vector3(randf_range(-10, 10), 0.1, randf_range(-7, 7))
		new_letter.rotation = Vector3(0,randf_range(0, 360) ,0)
		add_child.call_deferred(new_letter)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Label3D.text = str(SCORE) + " LAT DLA POCZTY PLOSKIEJ!"
