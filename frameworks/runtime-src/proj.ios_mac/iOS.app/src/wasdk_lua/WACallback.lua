WACallback = {
	onSuccess = function (t)
		print("onSuccess空实现")
	end
,
	onFailure = function (t)
		print("onFailure空实现")
	end
,
	onCancel = function (t)
		print("onCancel空实现")
	end

}


function WACallback:new (o)
	o = o or {} -- create object if user does not provide one
	setmetatable(o, self)
	self.__index = self
	return o
end