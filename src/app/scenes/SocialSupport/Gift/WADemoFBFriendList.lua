
require "app.uicommon.WADemoListView"
require "app.wasdklua.WACallback"
require "app.uicommon.WADemoLuaAlertView"
require "app.uicommon.WADemoItem"
require "app.wasdklua.WASocialProxy"

WADemoFBFriendList = class("WADemoFBFriendList", function()
    local listView = WADemoListView:new()   
    return listView
end)

function WADemoFBFriendList:ctor()
    self:setNeedBothBtn()
    self.leftBtn:setTitleText("send")
    self.rightBtn:setTitleText("ask")
 
end


function WADemoFBFriendList:displayFriendList(gift,friends)
    self.gift = gift

    for i,friend in ipairs(friends) do
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


    self:addClickEventListener(self.leftBtn,"send")
    self:addClickEventListener(self.rightBtn,"ask")

    self:reloadData()

    
end

function WADemoFBFriendList:addClickEventListener(btn,actionType)
    self.selectItems = {}
    btn:addClickEventListener(function (event)
        print(actionType)
        local friendIds = ""
        -- ID之间用","拼接
        for i,friend in ipairs(self.selectItems) do
            friendIds = friendIds .. friend.ID .. ","
        end
        --去掉最后一个","
        friendIds = string.sub(friendIds,1,string.len(friendIds) - 1)


        local callback = WACallback:new()
        callback = {
            onSuccess = function(a)
                local title = "发送成功"
                local recipients = ""
                if a.gameRequestDialog.content.recipients ~= nil then 
                    for i,recipt in ipairs(a.gameRequestDialog.content.recipients) do
                        recipients = recipients .. recipt .. ","
                    end
                end
                local message = "platform:" .. a.platform .. "\nobjectID:" .. a.gameRequestDialog.content.objectID .. "\nrecipients:" 
                .. recipients
                local cancelButtonTitle = "Sure"
                WADemoLuaAlertView.show(title,message,cancelButtonTitle,nil,nil,nil)
            end ,
            onFailure = function (a)
                local title = "发送失败"
                local message = "platform:" .. a.platform
                if a.error.domain ~= nil then message = message .. "\ndomain:" .. a.error.domain end
                if a.error.code ~= nil then message = message  .. "\ncode:" .. a.error.code end
                if a.error.userInfo ~= nil then message = message .. "\nuserInfo:" .. a.error.userInfo end

                local cancelButtonTitle = "Sure"
                WADemoLuaAlertView.show(title,message,cancelButtonTitle,nil,nil,nil) 
            end,
            onCancel = function(a)
                local title = "发送取消"
                local message = "platform:" .. a.platform 
                local cancelButtonTitle = "Sure"
                WADemoLuaAlertView.show(title,message,cancelButtonTitle,nil,nil,nil)
            end
        }
        local title = self.gift.title
        local message = "send a gift to you! This is " .. self.gift.title
        if actionType == "send" then
            print("self.actionType == send")
            -- WASocialProxy.fbSendGift(title, message, self.gift.ID, friendIds,callback)
            WASocialProxy.sendRequest("FACEBOOK", "SEND", title, message, self.gift.ID, friendIds, "",callback)
        elseif actionType == "ask" then
            print("self.actionType == ask")
            message = "ask you a gift " .. self.gift.title
            -- WASocialProxy.fbAskForGift(title, message, self.gift.ID, friendIds,callback)
            WASocialProxy.sendRequest("FACEBOOK", "ASKFOR", title, message, self.gift.ID, friendIds, "",callback)
        else
        end
    end)
end





