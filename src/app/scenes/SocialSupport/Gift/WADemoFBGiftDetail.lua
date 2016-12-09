
require "app.uicommon.WADemoListView"
require "app.wasdklua.WACallback"
require "app.uicommon.WADemoLuaAlertView"
require "app.uicommon.WADemoItem"
require "app.wasdklua.WASocialProxy"



WADemoFBGiftDetail = class("WADemoFBGiftDetail", function()
    local listView = WADemoListView:new()   
    return listView
end)

function WADemoFBGiftDetail:ctor()
	local actionAfterMoveOut = function()
		local parent = self:getParent()
		if parent ~= nil then parent:deleteGift(self.gift) end
	end
	self:setNeedLeftBtn()
	self.leftBtn:setTitleText("Handle")
	self.leftBtn:addClickEventListener(function (event)
		local callback = WACallback:new()
		callback.onSuccess = function(a)
			local title = "操作成功"
            local cancelButtonTitle = "Sure"
            WADemoLuaAlertView.show(title,"Success",cancelButtonTitle,nil,nil,nil)
            self:moveOut(actionAfterMoveOut)
		end

		callback.onFailure = function ()
			local title = "操作失败"
            -- local message = "platform:" .. a.platform
            local cancelButtonTitle = "Sure"
            WADemoLuaAlertView.show(title,"Failure",cancelButtonTitle,nil,nil,nil)
            self:moveOut(actionAfterMoveOut)
		end

        WASocialProxy.fbDeleteRequest(self.gift.ID, callback)
    end)
end

function WADemoFBGiftDetail:displayWithGift(gift)
	self.gift = gift
	local item1 = WADemoItem:new()
	item1:setLableText("ID:" .. gift.ID)
	self:addItem(item1)


	local item2 = WADemoItem:new()
	item2:setLableText("title:" .. gift.object.title)
	self:addItem(item2)

	local item3 = WADemoItem:new()
	item3:setLableText("from:" .. gift.from.name)
	self:addItem(item3)

	local item4 = WADemoItem:new()
	item4:setLableText("to:" .. gift.to.name)
	self:addItem(item4)

	local item5 = WADemoItem:new()
	item5:setLableText("message:" .. gift.message)
	self:addItem(item5)

	self:reloadData()
end





