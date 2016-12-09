WAUserProxy = {}

function WAUserProxy.setLoginFlowType(flowType)
	local param = {flowType = flowType}
	luaoc.callStaticMethod("WALuaUserProxy","setLoginFlowType",param)
end

function WAUserProxy.login(platform,extInfo,callback)
	 local param = {platform = platform,extInfo = extInfo,callback = callback}
	 luaoc.callStaticMethod("WALuaUserProxy","login",param)
end

function WAUserProxy.loginUI(enableCache,callback)
	 local param = {enableCache = enableCache,callback = callback}
	 luaoc.callStaticMethod("WALuaUserProxy","login",param)
end

function WAUserProxy.hide()
	luaoc.callStaticMethod("WALuaUserProxy","hide")
end

function WAUserProxy.logout()
	luaoc.callStaticMethod("WALuaUserProxy","logout")
end

function WAUserProxy.clearLoginCache()
	luaoc.callStaticMethod("WALuaUserProxy","clearLoginCache")
end

function WAUserProxy.bindingAccount(platform,extInfo,callback)
	local param = {platform = platform,extInfo = extInfo,callback = callback}
	luaoc.callStaticMethod("WALuaUserProxy","bindingAccount",param)
end

function WAUserProxy.queryBoundAccount(callback)
	local param = {callback = callback}
	luaoc.callStaticMethod("WALuaUserProxy","queryBoundAccount",param)
end

function WAUserProxy.unBindAccount(platform,platformUserId,callback)
	local param = {platform = platform,platformUserId = platformUserId,callback = callback}
	luaoc.callStaticMethod("WALuaUserProxy","unBindAccount",param)
end

function WAUserProxy.switchAccount(platform,callback)
	local param = {platform = platform , callback = callback}
	luaoc.callStaticMethod("WALuaUserProxy","switchAccount",param)
end

function WAUserProxy.createNewAccount(callback)
	local param = {callback = callback}
	luaoc.callStaticMethod("WALuaUserProxy","createNewAccount",param)
end

function WAUserProxy.openAccountManager()
	local param = {callback = callback}
	luaoc.callStaticMethod("WALuaUserProxy","openAccountManager",param)
end

function WAUserProxy.getAccountInfo(platform,callback)
	local param = {platform = platform,callback = callback}
	luaoc.callStaticMethod("WALuaUserProxy","getAccountInfo",param)
end

