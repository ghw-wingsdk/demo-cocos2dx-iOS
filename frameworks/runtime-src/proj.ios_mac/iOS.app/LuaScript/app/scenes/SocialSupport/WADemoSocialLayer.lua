
require "app.uicommon.WADemoNaviLayer"

WADemoShareLayer = class("WADemoShareLayer", function()
    local layer = WADemoNaviLayer:new()   
    return layer
end)

function WADemoShareLayer:ctor()

    self:setNaviTitle("数据收集")

    local button_1 = ccui.Button:create()
    button_1:setTitleText("PhotoUI")
    local button_2 = ccui.Button:create()
    button_2:setTitleText("PhotoApi")
    local button_3 = ccui.Button:create()
    button_3:setTitleText("VideoUI")
    local button_4 = ccui.Button:create()
    button_4:setTitleText("VideoApi")
    local button_5 = ccui.Button:create()
    button_5:setTitleText("LinkUI")
    local button_6 = ccui.Button:create()
    button_6:setTitleText("LinkApi")



    self:setBtnLayout({button_1,button_2,button_3,button_4,button_5,button_6},{1,1,1,1,1,1})
end


