
require "app.uicommon.WADemoNaviLayer"
require "app.scenes.SocialSupport.Invite.WADemoVKInviteLayer"
require "app.scenes.SocialSupport.Invite.WADemoFBInviteLayer"


WADemoInviteLayer = class("WADemoInviteLayer", function()
    local layer = WADemoNaviLayer:new()   
    return layer
end)

function WADemoInviteLayer:ctor()

    self:setNaviTitle("邀请")

    local button_1 = ccui.Button:create()
    button_1:setTitleText("FB")
    button_1:addClickEventListener(function (event)
        WADemoFBInviteLayer:new():addTo(self):moveIn()
    end)
    local button_2 = ccui.Button:create()
    button_2:setTitleText("VK")
    button_2:addClickEventListener(function (event)
        WADemoVKInviteLayer:new():addTo(self):moveIn()
    end)

    self:setBtnLayout({button_1,button_2},{1,1})
end


