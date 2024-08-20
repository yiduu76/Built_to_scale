extends Node2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@export var BOMB:Texture2D
@export var BOW:Texture2D
@export var EVIL:Texture2D
@export var PLAYER:Texture2D


var p_text:String:
	set(v):
		p_text = v
		if p_text in Glo.special_char:
			if is_node_ready():
				match p_text:
					"💣":
						sprite_2d.texture = BOMB
					"🏹":
						sprite_2d.texture = BOW
					"😈":
						sprite_2d.texture = EVIL
					"😋":
						sprite_2d.texture = PLAYER

var target_pos:Vector2:
	set(v):
		target_pos = v
		tween_to_pos(target_pos)
var end_pos:Vector2

func _ready() -> void:
	p_text = p_text
	await get_tree().create_timer(0.1).timeout
	var rand_angel = deg_to_rad(randf_range(0,360.0))
	var p_dir = Vector2.RIGHT.rotated(rand_angel)
	target_pos = p_dir * randf_range(14.0,49.0) + global_position
	
func tween_to_pos(p_pos:Vector2):
	if p_pos.is_equal_approx(global_position):
		queue_free()
	else :
		var p_tween = create_tween()
		p_tween.tween_property(self,"global_position",target_pos,0.5)
		p_tween.play()
		p_tween.finished.connect(to_end_pos)
		
func to_end_pos():
	target_pos = end_pos
