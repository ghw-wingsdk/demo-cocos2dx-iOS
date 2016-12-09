WACoreProxy = {}


function  WACoreProxy.setDebugMode(isDebugMode)
	local param = {isDebugMode = isDebugMode}
	luaoc.callStaticMethod("WALuaCoreProxy","setDebugMode".param)
end

function  WACoreProxy.setGameUserId(gameUserId)
	local param = {gameUserId = gameUserId}
	luaoc.callStaticMethod("WALuaCoreProxy","setGameUserId".param)
end

function  WACoreProxy.setServerId(serverId)
	local param = {serverId = serverId}
	luaoc.callStaticMethod("WALuaCoreProxy","setServerId".param)
end


function  WACoreProxy.setLevel(level)
	local param = {level = level}
	luaoc.callStaticMethod("WALuaCoreProxy","setLevel".param)
end

