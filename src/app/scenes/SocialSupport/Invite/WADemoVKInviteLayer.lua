
require "app.uicommon.WADemoNaviLayer"
require "app.scenes.SocialSupport.Invite.WADemoVKFriendList"
require "app.scenes.SocialSupport.Invite.WADemoVKGroupList"

WADemoVKInviteLayer = class("WADemoVKInviteLayer", function()
    local layer = WADemoNaviLayer:new()   
    return layer
end)

function WADemoVKInviteLayer:ctor()

    self:setNaviTitle("VK邀请")

    local button_1 = ccui.Button:create()
    button_1:setTitleText("invite")
    button_1:addClickEventListener(function (event)
        WADemoVKFriendList:new():addTo(self):moveIn()
    end)
    local button_2 = ccui.Button:create()
    button_2:setTitleText("app.groups")
    button_2:addClickEventListener(function (event)
        local groupList = WADemoVKGroupList:new():addTo(self):moveIn()
        groupList:queryGroups(1)
    end)
    local button_3 = ccui.Button:create()
    button_3:setTitleText("user.groups")
    button_3:addClickEventListener(function (event)
        local groupList = WADemoVKGroupList:new():addTo(self):moveIn()
        groupList:queryGroups(2)
    end)
    local button_4 = ccui.Button:create()
    button_4:setTitleText("all groups")
    button_4:addClickEventListener(function (event)
        local groupList = WADemoVKGroupList:new():addTo(self):moveIn()
        groupList:queryGroups(3)
    end)
    local button_5 = ccui.Button:create()
    button_5:setTitleText("getGroupById")
    button_5:addClickEventListener(function (event)
        local groupList = WADemoVKGroupList:new():addTo(self):moveIn()
        groupList:queryGroups(4)
    end)

    self:setBtnLayout({button_1,button_2,button_3,button_4,button_5},{1,1,1,1,1})
end


