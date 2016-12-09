
require "app.uicommon.WADemoNaviLayer"
require "app.uicommon.WADemoListView"
require "app.scenes.SocialSupport.Gift.WADemoFBGiftList"
require "app.scenes.SocialSupport.Gift.WADemoFBGiftBox"
require "app.wasdklua.WASocialProxy"

WADemoFBGiftLayer = class("WADemoFBGiftLayer", function()
    local layer = WADemoNaviLayer:new()   
    return layer
end)

function WADemoFBGiftLayer:ctor()

    self:setNaviTitle("FB礼物")

    local button_1 = ccui.Button:create()
    button_1:setTitleText("Gift(Send/Ask)")
    button_1:addClickEventListener(function (event)
        WADemoFBGiftList:new():addTo(self):setTitle("Gift(Send/Ask)"):moveIn()
    end)
    -- local button_2 = ccui.Button:create()
    -- button_2:setTitleText("Friends In Game")
    -- button_2:addClickEventListener(function (event)

    -- end)
    local button_3 = ccui.Button:create()
    button_3:setTitleText("Gift Box")
    button_3:addClickEventListener(function (event)
        WADemoFBGiftBox:new():addTo(self):moveIn()
    end)

    self:setBtnLayout({button_1,button_3},{1,1})
end


