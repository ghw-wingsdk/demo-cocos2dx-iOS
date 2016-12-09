
require "app.uicommon.WADemoNaviLayer"
require "app.wasdklua.WAUserProxy"
require "app.wasdklua.WACallback"
require "app.uicommon.WADemoLuaAlertView"

WADemoAcctSwitchLayer = class("WADemoAcctSwitchLayer", function()
    local layer = WADemoNaviLayer:new()   
    return layer
end)

function WADemoAcctSwitchLayer:assembleResult()
    local callback = WACallback:new()
        callback.onSuccess = function (a)
            local title = "切换成功"
            local message = "platform:" .. a.platform .. "\nuserId:" .. a.userId .. "\ntoken:" 
            .. a.token .. "\npUserId:" .. a.pUserId .. "\npToken:" .. a.pToken
            local cancelButtonTitle = "Sure"
            WADemoLuaAlertView.show(title,message,cancelButtonTitle,nil,nil,nil)

        end

        callback.onFailure = function(a)
            local title = "切换失败"
            local message = "platform:" .. a.platform
            if a.result.pUserId ~= nil then message = message .. "\npUserId:" .. a.result.pUserId end
            if a.result.pToken ~= nil then message = message .. "\npToken:" .. a.result.pToken end

            if a.error.domain ~= nil then message = message .. "\ndomain:" .. a.error.domain end
            if a.error.code ~= nil then message = message  .. "\ncode:" .. a.error.code end
            if a.error.userInfo ~= nil then message = message .. "\nuserInfo:" .. a.error.userInfo end

            local cancelButtonTitle = "Sure"
            WADemoLuaAlertView.show(title,message,cancelButtonTitle,nil,nil,nil) 
        end

        callback.onCancel = function(a)
            local title = "切换取消"
            local message = "platform:" .. a.platform
            local cancelButtonTitle = "Sure"
            WADemoLuaAlertView.show(title,message,cancelButtonTitle,nil,nil,nil)
        end
        return callback
end


function WADemoAcctSwitchLayer:ctor()

    self:setNaviTitle("切换账户")

    local button_1 = ccui.Button:create()
    button_1:setTitleText("FACEBOOK")
    button_1:addClickEventListener(function (event)
        local callback = self:assembleResult()
        WAUserProxy.switchAccount("FACEBOOK",callback)
    end) 
    local button_2 = ccui.Button:create()
    button_2:setTitleText("APPLE")
    button_2:addClickEventListener(function (event)
        local callback = self:assembleResult()
        WAUserProxy.switchAccount("APPLE",callback)
    end)
    local button_3 = ccui.Button:create()
    button_3:setTitleText("VK")
    button_3:addClickEventListener(function (event)
        local callback = self:assembleResult()
        WAUserProxy.switchAccount("VK",callback)
    end)

    self:setBtnLayout({button_1,button_2,button_3},{1,1,1})
end


