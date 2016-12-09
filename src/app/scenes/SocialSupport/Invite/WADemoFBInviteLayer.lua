
require "app.uicommon.WADemoNaviLayer"
require "app.wasdklua.WASocialProxy"
require "app.wasdklua.WACallback"
require "app.uicommon.WADemoLuaAlertView"
require "app.scenes.SocialSupport.Invite.WADemoFBInvitableFriendList"

WADemoFBInviteLayer = class("WADemoFBInviteLayer", function()
    local layer = WADemoNaviLayer:new()   
    return layer
end)

function WADemoFBInviteLayer:ctor()

    self:setNaviTitle("邀请")

    local button_1 = ccui.Button:create()
    button_1:setTitleText("Invite Friends")
    button_1:addClickEventListener(function (event)
        WADemoFBInvitableFriendList:new():addTo(self):moveIn()
    end)
    local button_2 = ccui.Button:create()
    button_2:setTitleText("Event reward")
    button_2:addClickEventListener(function (event)
        local callback = WACallback:new()
        callback.onSuccess = function(a)
            print("发送成功")
            local title = "发送成功"
            local message = "onSuccess"
            local cancelButtonTitle = "Sure"
            WADemoLuaAlertView.show(title,message,cancelButtonTitle,nil,nil,nil) 
        end
        callback.onFailure = function(a)
            print("发送失败")
            local title = "发送失败"
            local message = "onFailure"
            local cancelButtonTitle = "Sure"
            WADemoLuaAlertView.show(title,message,cancelButtonTitle,nil,nil,nil) 
        end
        WASocialProxy.inviteEventReward("WINGA", "testxia", callback)
    end)
    local button_3 = ccui.Button:create()
    button_3:setTitleText("FBAppInvite")
    button_3:addClickEventListener(function (event)
        local callback = WACallback:new()
        callback.onSuccess = function(a)
            print("邀请成功")
            local title = "邀请成功"
            local message = "onSuccess"
            local cancelButtonTitle = "Sure"
            WADemoLuaAlertView.show(title,message,cancelButtonTitle,nil,nil,nil) 
        end
        callback.onFailure = function(a)
            print("邀请失败")
            local title = "邀请失败"
            local message = "onFailure"
            local cancelButtonTitle = "Sure"
            WADemoLuaAlertView.show(title,message,cancelButtonTitle,nil,nil,nil) 
        end


        local appLinkUrl = "https://fb.me/1831135537104541"
        local previewImageUrl = "https://scontent-sjc2-1.xx.fbcdn.net/hphotos-xaf1/t39.2081-0/11057103_1038207922873472_1902526455_n.jpg"
        WASocialProxy.appInvite("FACEBOOK", appLinkUrl, previewImageUrl, callback)
    end)

    self:setBtnLayout({button_1,button_2,button_3},{1,1,1})
end


