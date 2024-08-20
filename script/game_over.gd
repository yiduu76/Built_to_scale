extends Control
const DEV = "res://tscn/dev.tscn"

func _ready() -> void:
	get_tree().paused = true

func _input(event: InputEvent) -> void:
	pass
	#if event is InputEventKey:
		#if event.is_action_pressed("ui_retry"):
			#Glo.reset()
			#get_tree().change_scene_to_file(DEV)
