
require "app.uicommon.WADemoNaviLayer"

WADemoVKGiftLayer = class("WADemoVKGiftLayer", function()
    local layer = WADemoNaviLayer:new()   
    return layer
end)

function WADemoVKGiftLayer:ctor()

    self:setNaviTitle("VK礼物")

    local button_1 = ccui.Button:create()
    button_1:setTitleText("Friends In Game")


    self:setBtnLayout({button_1},{1})
end


