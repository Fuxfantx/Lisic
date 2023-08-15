extends Node

var notice_scene = preload("res://ui/notice.scn")
var transition_scene = preload("res://ui/transition.tscn")

var InDynamic:bool = false
var InTransition:bool = false
var OnScreenFingers:int = 0

const idle_fps:int = 30

# 通知显示器
func display(param1:String):
	var new_notice = notice_scene.instantiate()
	new_notice.get_node("Contents").text = param1
	add_child(new_notice)

# 过场动画显示器
func transition():
	InTransition = true
	if Engine.target_fps == idle_fps : Engine.set_target_fps(60)
	add_child( transition_scene.instantiate() )

# 动画播放提示
func animation():
	InDynamic = true
	if Engine.target_fps == idle_fps : Engine.set_target_fps(200)

# 帧率管理：初始管理
func _init():
	Engine.set_target_fps(idle_fps)
	Input.set_use_accumulated_input(false)

# 帧率管理：针对LTPO设备进行节能
func _input(event):
	if event is InputEventScreenTouch and event.is_pressed(): OnScreenFingers +=1
	if event is InputEventScreenTouch and not(event.is_pressed()): OnScreenFingers -=1
	if OnScreenFingers == 0 and not(InDynamic or InTransition) :
		Engine.set_target_fps(idle_fps)
		return
	Engine.set_target_fps(200)
	return
