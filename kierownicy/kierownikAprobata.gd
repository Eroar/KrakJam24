extends Node3D

var audio_files = []

@onready var game = $'/root/Game'
@onready var interacteeZone = $'/root/Game/Player/InteracteeZone'
@onready var audioPlayer = $'AudioStreamPlayer3D'

func on_interaction(_interactable):
	game.addScoreOnly(0.1)

# Called when the node enters the scene tree for the first time.
func _ready():
	print("KierownikAprobataMesh ready with player: ", interacteeZone.get_name())
	interacteeZone.connect("interacting", on_interaction)
	var anim = $"KierownikAprobataMesh/AnimationPlayer"
	anim.get_animation("Aprobata").loop = true
	anim.play("Aprobata")

	var folder_path = "res://kierownicy/KierownikAprobata"
	var directory = DirAccess.open(folder_path)

	if directory:
		directory.list_dir_begin()
		var file_name = directory.get_next()
		while file_name != "":
			if file_name.ends_with(".mp3"):  # Replace with your audio file extension
				var audio_stream = load(folder_path + "/" + file_name)
				audio_files.append(audio_stream)
			file_name = directory.get_next()

	play_random_audio()
	# remove this node after audio player finish
	audioPlayer.connect("finished", queue_free)

# Play a random audio file
func play_random_audio():
	var random_index = randi() % audio_files.size()
	var random_audio = audio_files[random_index]
	audioPlayer.stream = random_audio
	audioPlayer.play()