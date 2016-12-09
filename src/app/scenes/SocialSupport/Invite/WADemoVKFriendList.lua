
require "app.uicommon.WADemoListView"
require "app.wasdklua.WACallback"
require "app.uicommon.WADemoLuaAlertView"
require "app.uicommon.WADemoItem"
require "app.wasdklua.WASocialProxy"

WADemoVKFriendList = class("WADemoVKFriendList", function()
    local listView = WADemoListView:new()   
    return listView
end)

function WADemoVKFriendList:ctor()
	self:setTitle("Friend List(VK)")
    self:queryFriends()
end


function WADemoVKFriendList:queryFriends()
	local qCallback = WACallback:new()
        qCallback.onSuccess = function(friends)
        	print("查询好友成功")
            for i,friend in ipairs(friends) do
            	local item = WADemoItem:new()
            	local text = ""
            	if friend.ID ~= nil then text = text .. "ID:" .. friend.ID end
            	if friend.name ~= nil then text = text .. " name:" .. friend.name end
            	item:setLableText(text)
            	item:setNeedLeftBtn()
            	item.leftBtn:setTitleText("Invite")
            	item.leftBtn:addClickEventListener(function (event)
            		local callback = WACallback:new()
            		callback.onSuccess = function (a)
            			print("邀请好友成功")
            			local title = "邀请好友成功"
			            local message = ""
			            if a.platform ~= nil then message = message .. "platform:" .. a.platform .. "\n" end
			            if a.result.from ~= nil then message = message .. "from:" .. a.result.from .. "\n" end
			            if a.result.to ~= nil then message = message .. "to:" .. a.result.to .. "\n" end
			            local cancelButtonTitle = "Sure"
			            WADemoLuaAlertView.show(title,message,cancelButtonTitle,nil,nil,nil)
			        end

			        callback.onFailure = function(a)
			        	local title = "邀请好友失败"
			            local message = ""
			            if a.platform ~= nil then message = message .. "platform:" .. a.platform .. "\n" end
			            if a.error.domain ~= nil then message = message .. "domain:" .. a.error.domain .. "\n" end
			            if a.error.code ~= nil then message = message .. "code:" .. a.error.code .. "\n" end
			            if a.error.userInfo ~= nil then message = message .. "userInfo:" .. a.error.userInfo end
			            local cancelButtonTitle = "Sure"
			            WADemoLuaAlertView.show(title,message,cancelButtonTitle,nil,nil,nil)
			        end

			        callback.onCancel = function(a)
			        	local title = "邀请好友取消"
			            local message = "OnCancel"
			            local cancelButtonTitle = "Sure"
			            WADemoLuaAlertView.show(title,message,cancelButtonTitle,nil,nil,nil)
			        end


			        WASocialProxy.sendRequest("VK", "REQUEST", "Game for you.", "Invite friend", nil, friend.ID, "",callback)
			    end)
            	self:addItem(item)
            end

            self:reloadData()

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
end






