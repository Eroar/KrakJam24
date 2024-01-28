extends Node3D

@export var SCORE:int = 0
var letter = preload("res://letter/Letter.tscn")
var aKierownik = preload("res://kierownicy/kierownikAprobata.tscn")
var dKierownik = preload("res://kierownicy/kierownikDysaprobata.tscn")
@onready var leweOkno = $LeweOkno
@onready var srodkoweOkno = $SrodkoweOkno
@onready var praweOkno = $PraweOkno

func makeItRain():
	for i in range(30):
		var new_letter = letter.instantiate()
		new_letter.position = Vector3(randf_range(-10, 10), 20, randf_range(-7, 7))
		new_letter.angular_velocity = Vector3(randf_range(0, 10), randf_range(0, 10), randf_range(0, 10))
		add_child.call_deferred(new_letter)

func updateScoreLabel():
	$Label3D.text = str(SCORE) + " LAT DLA POCZTY PLOSKIEJ!"

func addScore(points:int):
	SCORE += points
	updateScoreLabel()
	makeItRain()

func sleep(seconds:float):
	return await get_tree().create_timer(seconds).timeout

func spawnRandomKierownik():
	# choose random kierownik, aKierownik or dKierownik
	var randomKierownik = randi() % 2
	var newKierownik = aKierownik.instantiate() if randomKierownik==0 else dKierownik.instantiate()
	newKierownik.position = Vector3(0, 0, 0)

	var randomWindow = randi() % 3
	if randomWindow == 0:
		leweOkno.add_child.call_deferred(newKierownik)
	elif randomWindow == 1:
		srodkoweOkno.add_child.call_deferred(newKierownik)
	else:
		praweOkno.add_child.call_deferred(newKierownik)

# game loop
func _ready():
	updateScoreLabel()
		# wait between 3 - 8 seconds before spawning kierownik
	# var randomTime = randf_range(3, 8)
	while true:
		var randomTime = 5
		await sleep(randomTime)
		spawnRandomKierownik()


