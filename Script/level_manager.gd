class_name LevelManager
extends Node

var markers: Array[SpawnPoint] 

@export var levels : Array[PackedScene]
var level_count : int = 0

@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var fade: FadeTransition = $CanvasLayer/Fade

func _ready() -> void:
	for m: SpawnPoint in find_children("*", "SpawnPoint"):
		markers.append(m)
	canvas_layer.hide()
	load_level(level_count)

func load_level(level : int ) -> void :
	print(str(levels[level]))
	var level_in : Level = levels[level].instantiate()
	level_in.level_complete.connect(_on_level_complete)
	level_in.level_manager = self
	$Level.add_child(level_in)
	

func delete_level(level : int) -> void:
	$Level.get_child(0).queue_free()

func _on_level_complete(level_number : int):
	canvas_layer.show()
	fade.fade_tween()
	delete_level(level_count)
	level_count += 1
	load_level(level_count)
