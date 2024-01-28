extends Path3D

var t = 0.0

var pkg_list = [preload("res://package/package.tscn"),
				preload("res://package/packageBlue.tscn"),
				preload("res://package/packageRed.tscn")]
# Called when the node enters the scene tree for the first time.
func _ready():
	var random_package = pkg_list[randi_range(0, 2)].instantiate()
	random_package.add_to_group("package")
	$PathFollow3D.add_child.call_deferred(random_package)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	t += delta
	$PathFollow3D.progress = 3.0 * t
