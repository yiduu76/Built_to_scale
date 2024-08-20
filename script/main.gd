extends Node2D
@onready var player_body: Node2D = $Player/Body
@onready var player_sword: Node2D = $Player/Weapon
@onready var ey_body: Node2D = $Enemy/Body
@onready var ey_sword: Node2D = $Enemy/Weapon
@onready var player_anim: AnimationPlayer = $Player/AnimationPlayer
@onready var ey_anim: AnimationPlayer = $Enemy/AnimationPlayer
@onready var player_area_2d: Area2D = $Player/Body/Area2D
@onready var ey_area_2d: Area2D = $Enemy/Body/Area2D

const EMOJI_VFX = preload("res://tscn/emoji_vfx.tscn")
const ATK_NUMS = preload("res://tscn/atk_nums.tscn")
const center_pos = Vector2(320.0/2.0,180.0/2.0)

func _ready() -> void:
	Glo.settle_emoji.connect(_on_settle_emoji)
	player_anim.animation_finished.connect(reset_anim)
	ey_anim.animation_finished.connect(reset_anim)
	player_area_2d.area_entered.connect(on_player_hited)
	ey_area_2d.area_entered.connect(on_ey_hited)

func _process(_delta: float) -> void:
	do_tween()

func _on_settle_emoji(emoji:String,num:float):
	match emoji:
		"😋":
			create_emoji_vfx(center_pos,num,"😋",player_body.global_position)
			await get_tree().create_timer(1.1).timeout
			Glo.size = clampf((Glo.size + num),1,400)
		"🏹":
			Glo.atk = clampf((Glo.atk + num),1,100)
			create_emoji_vfx(center_pos,Glo.atk,"🏹",player_sword.global_position)
			await get_tree().create_timer(1.1).timeout
			player_anim.play("attk")
			create_atk_num(player_sword.get_parent(),Glo.atk)
		"🐣":
			create_emoji_vfx(center_pos,num,"🐣",ey_body.global_position)
			await get_tree().create_timer(1.1).timeout
			Glo.ey_size = clampf((Glo.ey_size + num),1,400)
		"💣":
			Glo.ey_atk = clampf((Glo.ey_atk + num),1,100)
			create_emoji_vfx(center_pos,Glo.ey_atk,"💣",ey_sword.global_position)
			await get_tree().create_timer(1.1).timeout
			ey_anim.play("attk")
			create_atk_num(ey_sword.get_parent(),Glo.ey_atk)
	lerp_to_defult(emoji)
	

func create_atk_num(node,num):
	var p_num = num
	for i in p_num:
		await get_tree().create_timer(randf_range(0.01,0.02)).timeout
		var p_vfx = ATK_NUMS.instantiate()
		node.add_child(p_vfx)
		if node.is_in_group("ey"):
			p_vfx.is_ey = true
		else :
			p_vfx.is_ey = false

func create_emoji_vfx(p_pos,num,p_emoji:String,p_end_pos:Vector2):
	var bigger_zero = (num > 0)
	var p_num = clampf(num,1,99)
	for i in p_num:
		var p_vfx = EMOJI_VFX.instantiate()
		add_child(p_vfx)
		p_vfx.get_child(0).text = p_emoji
		p_vfx.global_position = p_pos
		p_vfx.end_pos = p_end_pos
		if bigger_zero:
			pass
		else :
			p_vfx.modulate = Color.GREEN

func do_tween():
	var p_1 = clampf((Glo.size/100.0),0.1,2.0)
	player_body.scale = lerp(player_body.scale,Vector2(p_1,p_1) ,0.05)
	var p_2 = clampf((Glo.ey_size/100.0),0.1,2.0)
	ey_body.scale = lerp(ey_body.scale,Vector2(p_2,p_2),0.05)
	
	if Glo.atk > Glo.origin_atk:
		var p_3 = clampf((1.0 + (1.0/90.0) * (Glo.atk - 10.0)),0.1,2.0)
		player_sword.scale = lerp(player_sword.scale,Vector2(p_3,p_3),0.05)
	elif Glo.atk < Glo.origin_atk:
		var p_3 = clampf((1.0 + (1.0/9.0) * (Glo.atk - 10.0)),0.1,2.0)
		player_sword.scale = lerp(player_sword.scale,Vector2(p_3,p_3),0.05)
		
	var p_4 = clampf((Glo.ey_atk/10.0),0.1,2.0)
	ey_sword.scale = lerp(ey_sword.scale,Vector2(p_4,p_4),0.05)

func reset_anim(p_name:String):
	if p_name == "RESET":
		player_anim.play("idel")
		ey_anim.play("idel")
	else :
		player_anim.play("RESET")
		ey_anim.play("RESET")

func on_player_hited(area:Area2D):
	Glo.hp -= 1.0
	player_anim.play("hitted")

func on_ey_hited(area:Area2D):
	Glo.ey_hp -= 1.0
	ey_anim.play("hitted")

func lerp_to_defult(p_emoji:String):
	if p_emoji != "🏹":
		Glo.atk = lerp(Glo.atk,Glo.origin_atk,0.3)
	if p_emoji != "💣":
		Glo.ey_atk = lerp(Glo.ey_atk,Glo.origin_ey_atk,0.3)
	if p_emoji != "😋":
		Glo.size = lerp(Glo.size,100.0,0.3)
	if p_emoji != "🐣":
		Glo.ey_size = lerp(Glo.ey_size,100.0,0.3)

#func _on_timer_timeout() -> void:
	#pass
	#player_body.scale = lerp(player_body.scale,Vector2(1.0,1.0),0.05)
	#ey_body.scale = lerp(ey_body.scale,Vector2(1.0,1.0),0.05)
	#player_sword.scale = lerp(player_sword.scale,Vector2(1.0,1.0),0.05)
	#ey_sword.scale = lerp(ey_sword.scale,Vector2(1.0,1.0),0.05)
	#Glo.atk = lerp(Glo.atk,Glo.origin_atk,0.1)
	#Glo.ey_atk = lerp(Glo.ey_atk,Glo.origin_ey_atk,0.1)
	#Glo.size = lerp(Glo.size,100.0,0.05)
	#Glo.ey_size = lerp(Glo.ey_size,100.0,0.05)
