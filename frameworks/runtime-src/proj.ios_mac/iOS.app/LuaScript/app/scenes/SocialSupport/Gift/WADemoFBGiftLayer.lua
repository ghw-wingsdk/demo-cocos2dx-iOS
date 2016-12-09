
require "app.uicommon.WADemoNaviLayer"

WADemoFBGiftLayer = class("WADemoFBGiftLayer", function()
    local layer = WADemoNaviLayer:new()   
    return layer
end)

function WADemoFBGiftLayer:ctor()

    self:setNaviTitle("FB礼物")

    local button_1 = ccui.Button:create()
    button_1:setTitleText("Gift(Send/Ask)")
    local button_2 = ccui.Button:create()
    button_2:setTitleText("Friends In Game")
    local button_3 = ccui.Button:create()
    button_3:setTitleText("Gift Box")

    self:setBtnLayout({button_1,button_2,button_3},{1,1,1})
end


