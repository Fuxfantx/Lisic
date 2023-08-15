extends Node

############################
# 以下是LockID能力：locked(sth) / verify(sth)
# Verify结果为False，校验不通过；结果为Null，表示没有上锁
# 非发行版需要移除加密种子
func generate(sth:Dictionary):
	if not("1deal" in sth):
		return null
	if "LockID" in sth:
		sth.erase("LockID")
	var hashes:Array = []
	var current_hash
	for i in sth:
		current_hash = str(sth[i]).sha256_text()
		hashes.append(current_hash)
	current_hash = ""
	for i in hashes:
		current_hash += str(i)
	var hash2
	for i in sth:
		hash2 = str(i).sha256_text()
		hashes.append(hash2)
	var hashresult = "%s%s%s%s" % [current_hash,hash2,hash2,current_hash]
	return hashresult
func verify(sth):
	if not sth is Dictionary:
		return false
	if not("1deal" in sth):
		return false
	if not("LockID" in sth):
		return null
	var value = sth["LockID"]
	sth.erase("LockID")
	if value != generate(sth): return false
	return true
func locked(sth:Dictionary):
	if "LockID" in sth:
		sth.erase("LockID")
	sth["LockID"] = generate(sth)
	return sth
############################
