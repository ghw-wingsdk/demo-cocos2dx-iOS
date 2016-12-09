
require "app.uicommon.WADemoNaviLayer"
require "app.scenes.SocialSupport.Gift.WADemoFBGiftLayer"
require "app.scenes.SocialSupport.Gift.WADemoVKGiftLayer"

WADemoGiftLayer = class("WADemoGiftLayer", function()
    local layer = WADemoNaviLayer:new()   
    return layer
end)

function WADemoGiftLayer:ctor()

    self:setNaviTitle("礼物")

    local button_1 = ccui.Button:create()
    button_1:setTitleText("FB")
    button_1:addClickEventListener(function (event)
        WADemoFBGiftLayer:new():addTo(self):moveIn()
    end)
    local button_2 = ccui.Button:create()
    button_2:setTitleText("VK")
    button_2:addClickEventListener(function (event)
        WADemoVKGiftLayer:new():addTo(self):moveIn()
    end)

    self:setBtnLayout({button_1,button_2,button_3,button_4,button_5,button_6},{1,1})
end


