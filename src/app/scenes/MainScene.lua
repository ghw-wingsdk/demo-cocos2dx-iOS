
require "app.uicommon.WADemoNaviLayer"
require "app.scenes.Login.WADemoLoginLayer"
require "app.scenes.AccountManagement.WADemoAcctManageLayer"
require "app.scenes.AppTracking.WADemoAppTrackingLayer"
require "app.scenes.SocialSupport.Share.WADemoShareLayer"
require "app.scenes.SocialSupport.Invite.WADemoInviteLayer"
require "app.scenes.SocialSupport.Gift.WADemoGiftLayer"
require "app.wasdklua.WAApwProxy"
require "app.scenes.pay.WADemoProductList"
require "app.wasdklua.WATrackProxy"
require("src/cocos/cocos2d/json")

local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()

    local newLayer = WADemoNaviLayer:new()
    newLayer:addTo(self)
    newLayer:setNaviTitle("Cocos2dx-lua Demo")
    newLayer:setIsRoot()

    local button_1 = ccui.Button:create()
    
    local enableAppWall = true
    if enableAppWall == true 
        then 
        button_1:setTitleText("启动应用墙")
    else 
        button_1:setTitleText("禁用应用墙")
    end

    button_1:addClickEventListener(function (event)
        if enableAppWall == true 
            then 
            enableAppWall = false
            button_1:setTitleText("禁用应用墙")
            WAApwProxy.showEntryFlowIcon()
            
        else
            enableAppWall = true
            button_1:setTitleText("启用应用墙")
            WAApwProxy.hideEntryFlowIcon()
            
        end
    end)   

    local button_2 = ccui.Button:create()
    button_2:setTitleText("登录")
    button_2:addClickEventListener(function(event)  
        WADemoLoginLayer:new():addTo(self):moveIn()

        end ) 
    local button_3 = ccui.Button:create()
    button_3:setTitleText("账户管理")
    button_3:addClickEventListener(function (event)
        WADemoAcctManageLayer:new():addTo(self):moveIn()
    end)
    local button_4 = ccui.Button:create()
    button_4:setTitleText("支付")
    button_4:addClickEventListener(function (event)
        WADemoProductList:new():addTo(self):setTitle("支付"):moveIn()
    end)
    local button_5 = ccui.Button:create()
    button_5:setTitleText("数据收集")
    button_5:addClickEventListener(function (event)
        WADemoAppTrackingLayer:new():addTo(self):moveIn()
    end)
    local button_6 = ccui.Button:create()
    button_6:setTitleText("Facebook分享")
    button_6:addClickEventListener(function (event)
        WADemoShareLayer:new():addTo(self):moveIn()
    end)
    local button_7 = ccui.Button:create()
    button_7:setTitleText("邀请")
    button_7:addClickEventListener(function (event)
        WADemoInviteLayer:new():addTo(self):moveIn()
    end)
    local button_8 = ccui.Button:create()
    button_8:setTitleText("礼物")
    button_8:addClickEventListener(function (event)
        WADemoGiftLayer:new():addTo(self):moveIn()
    end)
    local button_9 = ccui.Button:create()
    button_9:setTitleText("闪退测试")

    newLayer:setBtnLayout({button_1,button_2,button_3,button_4,button_5,button_6,button_7,button_8,button_9},{2,2,2,2,0,1})

end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
