extends Node2D
@export var rand_ro_range:float = 45.0
@onready var atk_nums: Label = $atk_nums
@onready var area_2d: Area2D = $Area2D

const HIT_VFX = preload("res://tscn/hit_vfx.tscn")
var is_ey = false:
	set(v):
		is_ey = v
		if is_node_ready():
			set_layer()

func _ready() -> void:
	atk_nums.text = ["0","1"].pick_random()
	var p_rand = 0.0
	if global_position.x <= 160:
		p_rand = deg_to_rad(randf_range(-22.0,22.0))
	else :
		p_rand = deg_to_rad(randf_range(-22.0+180.0,22.0+180.0))
	rotate(p_rand)
	atk()

func set_layer():
	area_2d.set_collision_layer_value(2,!is_ey)
	area_2d.set_collision_layer_value(3,is_ey)
	area_2d.set_collision_mask_value(2,is_ey)
	area_2d.set_collision_mask_value(3,!is_ey)

func atk():
	var p_tween = create_tween()
	p_tween.tween_property(self,"position",position + Vector2(400,0).rotated(rotation),0.5)
	p_tween.play()
	await get_tree().create_timer(1.5).timeout
	queue_free()
	#p_tween.finished.connect(add_hit_vfx)

func add_hit_vfx():
	var p = HIT_VFX.instantiate()
	get_tree().current_scene.add_child(p)
	p.global_position = self.global_position
	p.emitting = true
	p.finished.connect(p.queue_free)


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("num"):
		return
	
	add_hit_vfx()
