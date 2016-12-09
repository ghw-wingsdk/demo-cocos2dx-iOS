
require "app.uicommon.WADemoNaviLayer"

WADemoAppTrackingLayer = class("WADemoAppTrackingLayer", function()
    local layer = WADemoNaviLayer:new()   
    return layer
end)

function WADemoAppTrackingLayer:ctor()

    self:setNaviTitle("数据收集")

    local button_1 = ccui.Button:create()
    button_1:setTitleText("Login")
    local button_2 = ccui.Button:create()
    button_2:setTitleText("initiatedPayment")
    local button_3 = ccui.Button:create()
    button_3:setTitleText("payment")
    local button_4 = ccui.Button:create()
    button_4:setTitleText("initiatedPurchase")
    local button_5 = ccui.Button:create()
    button_5:setTitleText("purchase")
    local button_6 = ccui.Button:create()
    button_6:setTitleText("levelAchieve")
    local button_7 = ccui.Button:create()
    button_7:setTitleText("userCreate")
    local button_8 = ccui.Button:create()
    button_8:setTitleText("userInfoUpdate")
    local button_9 = ccui.Button:create()
    button_9:setTitleText("goldUpdate")
    local button_10 = ccui.Button:create()
    button_10:setTitleText("taskUpdate")
    local button_11 = ccui.Button:create()
    button_11:setTitleText("userImport")


    self:setBtnLayout({button_1,button_2,button_3,button_4,button_5,button_6,button_7,button_8,button_9,button_10,button_11},{2,2,2,2,2,1})
end


