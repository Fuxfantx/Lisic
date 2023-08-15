extends Node

# 从IO调用文件相关API
var dir:Directory = Directory.new()
var json:JSON = JSON.new()
var file:File = File.new()


# 存档：全局属性
var Volume:String = "user://"
var Save:Dictionary = {}
const SaveTemplete:Dictionary = {
		"1deal":"Save",
		"Version":0.1,
		"Player":"1deal",
		"OFS1":0,"OFS2":0,
		"Lisic":{"CurrentBest":{},"TimeLine":{"Score":[],"ACC":[],"PTT":[],"JPoint":[],"CPoint":[],"VPoint":[],"PPoint":[],"IPoint":[],"TPoint":[],"Rank":[],"Status":[]},
		"Stastics":{"PlayCount":0,"FinishCount":0,"TimeCount":0,"PlayerPTT":0}},
		}


# 存档：初始化
func _init() -> void:

	# Android针对性设置
	if OS.has_feature("android"):
		OS.request_permissions()
		Volume = "/storage/emulated/0/1deal/"

	# 检测存档文件
	if not( file.file_exists(Volume + "Save") ):
		if file.open(Volume + "Save", File.WRITE):
			Notice.display("Please Restart 1deal.\nMake Sure You Allowed 1deal to Access the Storage.")
			return
		file.store_string( json.stringify( LockID.locked(SaveTemplete) , "", false) )
		file.close()

	# 加载存档
	file.open(Volume + "Save", File.READ)
	if json.parse(file.get_as_text()):
		Notice.display("JSON:Failed to parse Save.\nDelete Your Save File to Start as a New Player.")
		return
	Save = json.get_data()
	file.close()

	# 校验存档
	if LockID.verify( Save ) != true:
		Notice.display("Save invalid.\nDelete Your Save File to Start as a New Player.")
		Save = {}
	return


# 存档：更新（ 先修改IO.Save，再调用IO.save_update() )
func save_update():
	file.open(Volume + "Save", File.WRITE)
	file.store_string(   json.stringify( LockID.locked(Save), "", false)   )
	file.close()



# 曲目管理：全局属性
var C:float = 960 #屏幕中心x值
var Mode:String = "" #当前模式
var ButtonCount:int = 0 #有多少个Card的按钮被按下
var InChart:bool = false #进入谱面选择器/游戏界面的提示
var OFS2:bool = false #使用第二套Offset
var SongNum:int = 0

# 曲目管理：获取音频流
func get_stream(song:String, insong:bool = false):
	if not insong:
		if not file.file_exists(Volume + song + "/" + "Audio.mp3"):
			return null
		file.open(Volume + song + "/" + "Audio.mp3", File.READ)
	else: file.open("res://insong/" + song + "/" + "Audio.mp3", File.READ)
	var data = file.get_buffer( file.get_length() )
	var stream = AudioStreamMP3.new()
	stream.data = data
	file.close()
	return stream

# 曲目管理：获取曲目列表
func songlist():
	dir.open(Volume)
	var list1:PackedStringArray = dir.get_directories()
	var list2:PackedStringArray = []
	for i in list1:
		if dir.file_exists(i + "/Audio.mp3")  and ( dir.dir_exists(i + "/" + Mode) ): list2.append(i)
	dir = Directory.new()
	return list2



# 播放器：全局属性
var ChartInvalid:bool #谱面未正确定稿
var ENC_Mode:bool = false #加密模式

# 播放器：解析谱面
func get_chart(song:String, chartname:String, insong:bool = false):
	#############################################
	if not ENC_Mode:
		if insong: file.open("res://insong/" + song + "/" + Mode + "/" + chartname, File.READ)
		else: file.open(Volume + song + "/" + Mode + "/" + chartname, File.READ)
	#############################################
	json.parse(file.get_as_text())
	file.close()
	var fumen = json.get_data()
	json = JSON.new()
	if not fumen is Dictionary:
		Notice.display("Failed to Parse the Chart.")
		return null
	var verify_result = LockID.verify(fumen)
	if verify_result == null:
		ChartInvalid = true
		Notice.display("Chart Not Finalized.\nYour Score Won't Be Saved.\n\n\n————————        WARNING        ————————\nTurning 1deal to the Background while Your Play\nLeads to Abnormal Behaviors.")
		return fumen
	elif verify_result == false:
		ChartInvalid = true
		Notice.display("Chart Not Finalized.\nYour Score Won't Be Saved.\n\n\n————————        WARNING        ————————\nTurning 1deal to the Background while Your Play\nLeads to Abnormal Behaviors.")
		return fumen
	ChartInvalid = false
	Notice.display("————————        WARNING        ————————\nTurning 1deal to the Background while Your Play\nLeads to Abnormal Behaviors.")
	return fumen

# 临时更新：谱面加密解密！
func encrypt_chart(song:String, chartname:String, password:String, insong:bool = false):
	#############################################
	if insong: file.open("res://insong/" + song + "/" + Mode + "/" + chartname, File.READ)
	else: file.open(Volume + song + "/" + Mode + "/" + chartname, File.READ)
	#############################################
	json.parse(file.get_as_text())
	file.close()
	var fumen = json.get_data()
	#############################################
	if insong: file.open_encrypted_with_pass("res://insong/" + song + "/" + Mode + "/" + chartname, File.WRITE, password)
	else: file.open_encrypted_with_pass(Volume + song + "/" + Mode + "/" + chartname, File.WRITE, password)
	#############################################
	file.store_string( json.stringify(LockID.locked(fumen), "", false, false) )
	json = JSON.new
	file.close()

func get_encrypted_chart(song:String, chartname:String, password:String, insong:bool = false):
	ENC_Mode = true
	if insong: file.open_encrypted_with_pass("res://insong/" + song + "/" + Mode + "/" + chartname, File.READ, password)
	else: file.open_encrypted_with_pass(Volume + song + "/" + Mode + "/" + chartname, File.READ, password)
	var result:Dictionary = get_chart(song, chartname, insong)
	ENC_Mode = false
	return result
