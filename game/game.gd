extends Node3D

@export var SCORE:float = 0.0
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
	var scoreInt = int(SCORE)
	$Label3D.text = str(scoreInt) + " LAT DLA POCZTY PLOSKIEJ!"

func addScore(points:int):
	SCORE += points
	updateScoreLabel()
	makeItRain()
func addScoreOnly(points:int):
	SCORE += points
	updateScoreLabel()

func removeScore(points:float):
	SCORE -= points
	if SCORE < 0:
		SCORE = 0
	updateScoreLabel()

func sleep(seconds:float):
	return await get_tree().create_timer(seconds).timeout

func getRandomOkno():
	var randomWindow = randi() % 3
	if randomWindow == 0:
		return leweOkno
	elif randomWindow == 1:
		return srodkoweOkno
	else:
		return praweOkno

func spawnRandomKierownik():
	# choose random kierownik, aKierownik or dKierownik
	var randomKierownik = randi() % 2
	var newKierownik = aKierownik.instantiate() if randomKierownik==0 else dKierownik.instantiate()
	newKierownik.position = Vector3(0, 0, 0)

	var randomOkno = getRandomOkno()
	randomOkno.addKierownik(newKierownik)

# game loop
func _ready():
	updateScoreLabel()
		# wait between 3 - 8 seconds before spawning kierownik
	# var randomTime = randf_range(3, 8)
	while true:
		var randomTime = 5
		await sleep(randomTime)
		spawnRandomKierownik()


