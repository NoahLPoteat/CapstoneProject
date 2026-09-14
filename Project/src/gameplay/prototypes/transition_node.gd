class_name ScreenTransitionHandler extends Control
signal trans_started()
signal trans_ended()

##emitted when the transition finishes
##	is_on = true when the transition finishes while covering the screen
##	is_on = false when when trans finishes and reveals the screen
signal trans_finished()

@export var trans_time: float = 1.0
@export var ease_type: Tween.EaseType
@export var trans_type: Tween.TransitionType
@onready var effectee: TextureRect = $TextureRect

##Abstract
#Create a tween object
#make a tween reset functoin
#on begin_trans tween the shaderparam intensity to 0.0 over trans_time (use the trans params)
#then emit signals as needed
#
#on end_trans
#do the same thing but tween intensity to 1.0

#Viv was here <- HELLO



var tween: Tween

func _ready() -> void:
	#while true:
		#begin_transition()
		#await tween.finished
		#end_transition()
		#await tween.finished
	pass
func reset_tween():
	if tween:
		tween.kill()
	tween = get_tree().create_tween().set_ease(ease_type).set_trans(trans_type).set_parallel(true)

func begin_transition():
	reset_tween()
	trans_started.emit()
	tween.tween_method(set_shader_param, 1.0, 0.0, trans_time);
	await tween.finished
	trans_finished.emit(true)

func end_transition():
	reset_tween()
	trans_ended.emit()
	tween.tween_method(set_shader_param, 0.0, 1.0, trans_time);
	await tween.finished
	trans_finished.emit(false)

func set_shader_param(val: float):
	var mat: ShaderMaterial = effectee.material
	mat.set_shader_parameter("intensity", val)
