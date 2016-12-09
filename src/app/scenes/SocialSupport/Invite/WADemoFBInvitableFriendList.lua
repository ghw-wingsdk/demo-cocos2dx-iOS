
require "app.uicommon.WADemoListView"
require "app.wasdklua.WACallback"
require "app.uicommon.WADemoLuaAlertView"
require "app.uicommon.WADemoItem"
require "app.wasdklua.WASocialProxy"

WADemoFBInvitableFriendList = class("WADemoFBInvitableFriendList", function()
    local listView = WADemoListView:new()   
    return listView
end)

function WADemoFBInvitableFriendList:ctor()
	self:setTitle("Friend List(FB)")
    self:setNeedLeftBtn()
    self.leftBtn:setTitleText("Invite")
    self.selectItems = {}
    self.leftBtn:addClickEventListener(function (event)
        self:inviteFriends()
    end)

    self:queryInvitableFriends()
end


function WADemoFBInvitableFriendList:queryInvitableFriends()
    local callback = WACallback:new()
    callback.onSuccess = function(result)
        for i,friend in ipairs(result) do
            local item = WADemoItem:new()
            item:setLableText(friend.name)


            local function selectedEvent(sender,eventType)

                if eventType == ccui.CheckBoxEventType.selected then

                    table.insert(self.selectItems,friend)

                elseif eventType == ccui.CheckBoxEventType.unselected then

                    for i,sfriend in ipairs(self.selectItems) do
                        if sfriend.ID == friend.ID then table.remove(self.selectItems,i) break end
                    end

                end
            end
            
            item:setNeedCheckbox(selectedEvent)
            self:addItem(item)
        end

        self:reloadData()
    end
    callback.onFailure = function(a)
        print("查询失败")
        local title = "查询失败"
        local message = "onFailure"
        local cancelButtonTitle = "Sure"
        WADemoLuaAlertView.show(title,message,cancelButtonTitle,nil,nil,nil) 
    end
    WASocialProxy.queryInvitableFriends("FACEBOOK", 1, callback)
end

function WADemoFBInvitableFriendList:inviteFriends()
    local friendIds = ""
        -- ID之间用","拼接
        for i,friend in ipairs(self.selectItems) do
            friendIds = friendIds .. friend.ID .. ","
        end
        --去掉最后一个","
        friendIds = string.sub(friendIds,1,string.len(friendIds) - 1)

        local callback = WACallback:new()
        callback.onSuccess = function(a)
            -- 发送邀请消息
            if a.result ~= nil then 
                local iCallback = WACallback:new()
                iCallback.onSuccess = function(a)
                    print("发送邀请信息成功")
                    local title = "发送邀请信息成功"
                    local message = "onSuccess"
                    local cancelButtonTitle = "Sure"
                    WADemoLuaAlertView.show(title,message,cancelButtonTitle,nil,nil,nil) 
                end
                iCallback.onFailure = function(a)
                    print("发送邀请信息失败")
                    local title = "发送邀请信息失败"
                    local message = "onFailure"
                    local cancelButtonTitle = "Sure"
                    WADemoLuaAlertView.show(title,message,cancelButtonTitle,nil,nil,nil) 
                end
                WASocialProxy.createInviteRecord("FACEBOOK", a.result,iCallback)
            end
        end
        callback.onFailure = function(a)
            print("发送失败")
            local title = "发送失败"
            local message = "onFailure"
            local cancelButtonTitle = "Sure"
            WADemoLuaAlertView.show(title,message,cancelButtonTitle,nil,nil,nil) 
        end

        callback.onCancel = function()
            print("发送取消")
            local title = "发送取消"
            local message = "onCancel"
            local cancelButtonTitle = "Sure"
            WADemoLuaAlertView.show(title,message,cancelButtonTitle,nil,nil,nil) 
        end

        -- WASocialProxy.gameInvite("FACEBOOK", "Game for you.", "Take this bomb to blast your way to victory!!!", friendIds, callback)
        WASocialProxy.sendRequest("FACEBOOK", "INVITE", "Game for you.", "Take this bomb to blast your way to victory!!!", nil, friendIds,"",callback)
end






