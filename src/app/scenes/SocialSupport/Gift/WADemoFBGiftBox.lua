
require "app.uicommon.WADemoListView"
require "app.wasdklua.WACallback"
require "app.uicommon.WADemoLuaAlertView"
require "app.uicommon.WADemoItem"
require "app.wasdklua.WASocialProxy"
require "app.scenes.SocialSupport.Gift.WADemoFBGiftDetail"


WADemoFBGiftBox = class("WADemoFBGiftBox", function()
    local listView = WADemoListView:new()   
    return listView
end)

function WADemoFBGiftBox:ctor()
	self:setTitle("Gift Box(Received)")
    self:queryGifts("received")
    self:setNeedBothBtn()
    self.leftBtn:setTitleText("received")
    self.leftBtn:addClickEventListener(function (event)
        self:queryGifts("received")
    end)
    self.rightBtn:setTitleText("asked")
    self.rightBtn:addClickEventListener(function (event)
        self:queryGifts("asked")
    end)

    self.gifts = {}
end


function WADemoFBGiftBox:queryGifts(giftType)
	local callback = WACallback:new()
	callback.onSuccess = function(result)
		
		if giftType == "received" 
			then self:setTitle("Gift Box(Received)")
		else
			self:setTitle("Gift Box(Asked)")
		end

		self:clearItems()
		self.gifts = {}
		for i,gift in ipairs(result) do
			table.insert(self.gifts,gift)
			local text = ""
			if gift.object.title ~= nil then text = text .. gift.object.title end
			if gift.ID ~= nil then text = text .. " ID:" .. gift.ID end
			local item = WADemoItem:new()
			item:setLableText(text)
			item:setNeedLeftBtn()
			item.leftBtn:setTitleText("Check")
			item.leftBtn:addClickEventListener(function (event)
		        local giftDetail = WADemoFBGiftDetail:new():setTitle("Gift Detail"):addTo(self):moveIn()
		        giftDetail:displayWithGift(gift)
		    end)
			self:addItem(item)
		end

		self:reloadData()
	end

	callback.onFailure = function(error)
		print("查询失败")
	end
	if giftType == "received" 
		then
		 WASocialProxy.fbQueryReceivedGifts(callback)
	else
		WASocialProxy.fbQueryAskForGiftRequests(callback)
	end
	
end

function WADemoFBGiftBox:deleteGift(gift)
	local index = -1
	for i,aGift in ipairs(self.gifts) do
		if aGift.ID == gift.ID 
			then 
			table.remove(self.gifts,i) 
			index = i
			break
	    end
	end

	if index ~= -1 then self:deleteItem(index) end


end



