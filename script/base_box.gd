extends Label
@onready var sprite_2d: Sprite2D = $Sprite2D
#"😋","💣","🏹","😈"
#const BOMB = "res://asset/pictures/svgs/bomb.svg"
#const BOW = "res://asset/pictures/svgs/bow.png"
#const EVIL = "res://asset/pictures/svgs/evil.png"
#const PLAYER = "res://asset/pictures/svgs/player.png"
@export var BOMB:Texture2D
@export var BOW:Texture2D
@export var EVIL:Texture2D
@export var PLAYER:Texture2D
@export var EMPTY:Texture2D

@export var p_text:String:
	set(v):
		p_text = v
		if is_node_ready():
			if p_text in Glo.special_char:
				match p_text:
					"💣":
						sprite_2d.texture = BOMB
					"🏹":
						sprite_2d.texture = BOW
					"😈":
						sprite_2d.texture = EVIL
					"😋":
						sprite_2d.texture = PLAYER
			else:
				text = v
				sprite_2d.texture = EMPTY

func _ready() -> void:
	p_text = p_text

func create_image():
	var p_ = Image.new()
	#p_.create_from_data()
	pass
