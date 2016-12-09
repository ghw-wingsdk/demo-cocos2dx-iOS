WAPayProxy = {}

function WAPayProxy.isPayServiceAvailable(platform)
	local param = {platform = platform}
	luaoc.callStaticMethod("WALuaPayProxy","isPayServiceAvailable",param)
end

function WAPayProxy.initialize(callback)
	local param = {callback = callback}
	luaoc.callStaticMethod("WALuaPayProxy","initialize",param)
end

function WAPayProxy.queryInventory(callback)
	local param = {callback = callback}
	luaoc.callStaticMethod("WALuaPayProxy","queryInventory",param)
end

function WAPayProxy.payUI(platform)
	local param = {platform = platform}
	luaoc.callStaticMethod("WALuaPayProxy","payUI",param)
end