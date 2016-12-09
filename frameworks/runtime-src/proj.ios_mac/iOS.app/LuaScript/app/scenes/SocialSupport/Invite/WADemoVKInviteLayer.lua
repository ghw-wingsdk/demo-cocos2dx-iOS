
require "app.uicommon.WADemoNaviLayer"

WADemoVKInviteLayer = class("WADemoVKInviteLayer", function()
    local layer = WADemoNaviLayer:new()   
    return layer
end)

function WADemoVKInviteLayer:ctor()

    self:setNaviTitle("VK邀请")

    local button_1 = ccui.Button:create()
    button_1:setTitleText("invite")
    local button_2 = ccui.Button:create()
    button_2:setTitleText("app.groups")
    local button_3 = ccui.Button:create()
    button_3:setTitleText("user.groups")
    local button_4 = ccui.Button:create()
    button_4:setTitleText("all groups")

    self:setBtnLayout({button_1,button_2,button_3,button_4},{1,1,1,1})
end


