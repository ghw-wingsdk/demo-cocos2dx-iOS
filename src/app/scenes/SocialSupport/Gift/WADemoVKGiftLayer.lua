
require "app.uicommon.WADemoNaviLayer"
require "app.uicommon.WADemoListView"
require "app.wasdklua.WACallback"
require "app.uicommon.WADemoLuaAlertView"
require "app.uicommon.WADemoItem"
require "app.wasdklua.WASocialProxy"

WADemoVKGiftLayer = class("WADemoVKGiftLayer", function()
    local layer = WADemoNaviLayer:new()   
    return layer
end)

function WADemoVKGiftLayer:ctor()

    self:setNaviTitle("VK礼物")

    local button_1 = ccui.Button:create()
    button_1:setTitleText("Friends In Game")
    button_1:addClickEventListener(function (event)
        local friendList = WADemoListView:new():setTitle("Frined List(VK)"):addTo(self):moveIn()
        local qCallback = WACallback:new()
        qCallback.onSuccess = function(friends)
        	print("查询好友成功")
            for i,friend in ipairs(friends) do
            	local item = WADemoItem:new()
            	local text = ""
            	if friend.ID ~= nil then text = text .. "ID:" .. friend.ID end
            	if friend.name ~= nil then text = text .. " name:" .. friend.name end
            	item:setLableText(text)
            	friendList:addItem(item)
            end

            friendList:reloadData()

        end
        qCallback.onFailure = function(a)
            print("查询好友失败")
            local title = "查询好友失败"
            local message = "domain:" .. a.error.domain .. "\n"
            message = message .. "code:" .. a.error.code .. "\n"
            message = message .. "userInfo:" .. a.error.userInfo
            local cancelButtonTitle = "Sure"
            WADemoLuaAlertView.show(title,message,cancelButtonTitle,nil,nil,nil)
        end
        WASocialProxy.queryFriends("VK",qCallback)

    end)

    self:setBtnLayout({button_1},{1})
end


