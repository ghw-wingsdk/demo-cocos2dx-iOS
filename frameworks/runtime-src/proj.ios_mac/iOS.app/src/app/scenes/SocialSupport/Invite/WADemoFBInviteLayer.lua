
require "app.uicommon.WADemoNaviLayer"

WADemoFBInviteLayer = class("WADemoFBInviteLayer", function()
    local layer = WADemoNaviLayer:new()   
    return layer
end)

function WADemoFBInviteLayer:ctor()

    self:setNaviTitle("邀请")

    local button_1 = ccui.Button:create()
    button_1:setTitleText("Invite Friends")
    local button_2 = ccui.Button:create()
    button_2:setTitleText("Event reward")
    local button_3 = ccui.Button:create()
    button_3:setTitleText("FBAppInvite")

    self:setBtnLayout({button_1,button_2,button_3},{1,1,1})
end


