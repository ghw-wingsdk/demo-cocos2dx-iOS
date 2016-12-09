
require "app.uicommon.WADemoNaviLayer"
require "app.wasdklua.WAUserProxy"
require "app.wasdklua.WACallback"

WADemoLoginLayer = class("WADemoLoginLayer", function()
    local layer = WADemoNaviLayer:new()   
    return layer
end)

function WADemoLoginLayer:ctor()

    self:setNaviTitle("登录")

    local button_1 = ccui.Button:create()
    button_1:setTitleText("登录时不重新绑定设备")
    local button_2 = ccui.Button:create()
    button_2:setTitleText("Facebook登录")
    local button_3 = ccui.Button:create()
    button_3:setTitleText("Apple登录")
    local button_4 = ccui.Button:create()
    button_4:setTitleText("VK登录")
    local button_5 = ccui.Button:create()
    button_5:setTitleText("访客登录")
    button_5:addClickEventListener(function (event)
        local callback = WACallback:new()
        callback.onSuccess = function ()
            print("登录成功...")
        end

        callback.onFailure = function()
            print("登录失败")
        end

        callback.onCancel = function()
            print("登录取消")
        end
        WAUserProxy.login("WINGAA","",callback)
    end)
    local button_6 = ccui.Button:create()
    button_6:setTitleText("应用内登录")
    local button_7 = ccui.Button:create()
    button_7:setTitleText("登录窗口")
    local button_8 = ccui.Button:create()
    button_8:setTitleText("不缓存登录方式")
    local button_9 = ccui.Button:create()
    button_9:setTitleText("登出")
    


    self:setBtnLayout({button_1,button_2,button_3,button_4,button_5,button_6,button_7,button_8,button_9},{1,2,2,1,2,1})
end 

