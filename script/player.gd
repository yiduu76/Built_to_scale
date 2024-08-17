extends Node2D
#@export var chars : String = "=":
	#set(v):
		#chars = v
		#if is_node_ready():
			#clear_chars()
			#spawn_chars()
#@export var move_speed:float = 20.0
#
#func _ready() -> void:
	#chars = "12*3="
	#
#
#func _process(delta: float) -> void:
	#_move(delta)
#
#func _move(delta):
	#self.global_position += Glo.input_dir * delta * move_speed
	#self.rotation = Glo.input_dir.angle()
#
#func spawn_chars():
	#var invert_chars = Glo.reverse_string(chars)
	#for i in chars.length():
		#var p_label = Label.new()
		#p_label.text = invert_chars[i]
		#add_child(p_label)
		#p_label.position = Vector2(-12*i,0)
#
#func clear_chars():
	#for i in self.get_children():
		#i.queue_free()
