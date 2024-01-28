extends Node3D

@onready var light = $Light

func addKierownik(kierownik):
	add_child.call_deferred(kierownik)
	light.light_color = kierownik["metadata/lightColor"]


	

