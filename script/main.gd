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
			# var p_ = clampf((num + 100.0)/1000.0,0.5,3.0)
			create_emoji_vfx(center_pos,num,"😋",player_body.global_position)
			await get_tree().create_timer(1.1).timeout
			Glo.size = clampf((100.0 + num),1,400)
			# do_tween(player_body,Vector2(p_, p_))
		"🏹":
			# var p_ = clampf((num + 100.0)/1000.0,0.5,2.0)
			create_emoji_vfx(center_pos,num,"🏹",player_sword.global_position)
			await get_tree().create_timer(1.1).timeout
			# do_tween(player_sword,Vector2(p_, p_))
			player_anim.play("attk")
			Glo.atk = clampf((0 + num),1,100)
			create_atk_num(player_sword.get_parent(),Glo.atk)
		"🐣":
			# var p_ = clampf((num + 100.0)/1000.0,0.5,3.0)
			create_emoji_vfx(center_pos,num,"🐣",ey_body.global_position)
			await get_tree().create_timer(1.1).timeout
			Glo.ey_size = clampf((100.0 + num),1,400)
			# do_tween(ey_body,Vector2(p_, p_))
		"💣":
			# var p_ = clampf((num + 100.0)/1000.0,0.5,2.0)
			create_emoji_vfx(center_pos,num,"💣",ey_sword.global_position)
			await get_tree().create_timer(1.1).timeout
			# do_tween(ey_sword,Vector2(p_, p_))
			ey_anim.play("attk")
			Glo.ey_atk = clampf((10 + num),1,100)
			create_atk_num(ey_sword.get_parent(),Glo.ey_atk)

func create_atk_num(node,num):
	var p_num = clampi(abs(int(num)),1,100)
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
	var p_num = clampi(abs(int(num/50.0)),1,50)
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

# func do_tween(target,target_scale):
func do_tween():
	player_body.scale = lerp(player_body.scale,Glo.size/100.0,0.05)
	ey_body.scale = lerp(ey_body.scale,Glo.ey_size/100.0,0.05)
	player_sword.scale = lerp(player_sword.scale,Glo.atk/100.0,0.05)
	ey_sword.scale = lerp(ey_sword.scale,Glo.ey_atk/100.0,0.05)

	# var p_tween = create_tween()
	# p_tween.tween_property(target,"scale",target_scale,0.7)
	# p_tween.play()

func reset_anim(p_name:String):
	if p_name == "RESET":
		player_anim.stop()
		ey_anim.stop()
	else :
		player_anim.play("RESET")
		ey_anim.play("RESET")

func on_player_hited(area:Area2D):
	Glo.hp -= 1.0

func on_ey_hited(area:Area2D):
	Glo.ey_hp -= 1.0

func _on_timer_timeout() -> void:
	player_body.scale = lerp(player_body.scale,Vector2(1,1),0.05)
	ey_body.scale = lerp(ey_body.scale,Vector2(1,1),0.05)
	player_sword.scale = lerp(player_sword.scale,Vector2(1,1),0.05)
	ey_sword.scale = lerp(ey_sword.scale,Vector2(1,1),0.05)
	Glo.atk = lerp(Glo.atk,0,0.05)
	Glo.ey_atk = lerp(Glo.ey_atk,0,0.05)
	Glo.size = lerp(Glo.size,100,0.05)
	Glo.ey_size = lerp(Glo.ey_size,100,0.05)


