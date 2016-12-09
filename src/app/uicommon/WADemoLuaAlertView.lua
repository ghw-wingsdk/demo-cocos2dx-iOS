WADemoLuaAlertView = {}


function WADemoLuaAlertView.show(title,message,cancelButtonTitle,otherButtonTitles,cancelFunc,otherFunc)
	local param = {title = title,message = message,cancelButtonTitle = cancelButtonTitle,otherButtonTitles = otherButtonTitles,cancelFunc = cancelFunc ,otherFunc = otherFunc}
	luaoc.callStaticMethod("WADemoLuaAlertViewAdapter","show",param)
end