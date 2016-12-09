
require "app.uicommon.WADemoNaviLayer"
require "app.uicommon.WADemoLuaAlertView"
require "app.wasdklua.WAUserProxy"
require "app.wasdklua.WACallback"
require "app.wasdklua.WAApwProxy"
require "app.wasdklua.WACoreProxy"
require "app.wasdklua.WASocialProxy"


WADemoLoginLayer = class("WADemoLoginLayer", function()
    local layer = WADemoNaviLayer:new()   
    return layer
end)

-- 发送安装事件
function WADemoLoginLayer:inviteInstallReward(platform,token)
    if (platform ~= nil and (platform == "VK" or platform == "FACEBOOK")) and (token ~= nil)
    then
        local callback = WACallback:new()
        callback.onSuccess = function(a)
            local title = "发送安装事件成功"
            local message = "onSuccess"
            local cancelButtonTitle = "Sure"
            WADemoLuaAlertView.show(title,message,cancelButtonTitle,nil,nil,nil)
        end

        callback.onFailure = function(a)
            local title = "发送安装事件失败"
            local message = "onFailure"
            local cancelButtonTitle = "Sure"
            WADemoLuaAlertView.show(title,message,cancelButtonTitle,nil,nil,nil)
        end
        WASocialProxy.inviteInstallReward(platform,token,callback)
    end

end

function WADemoLoginLayer:assembleLoginCallback()
    local callback = WACallback:new()
        callback.onSuccess = function (a)
            -- 登录成功
            --设置serverId
            WACoreProxy.setServerId("China")
            --设置gameUserId
            WACoreProxy.setGameUserId("12345")

            --设置Level
            WACoreProxy.setLevel(10)
            
            -- 发送安装事件

           self:inviteInstallReward(a.platform,a.token)

            local title = "登录成功"
            local message = "platform:" .. a.platform .. "\nuserId:" .. a.userId .. "\ntoken:" 
            .. a.token .. "\npUserId:" .. a.pUserId .. "\npToken:" .. a.pToken
            local cancelButtonTitle = "Sure"
            WADemoLuaAlertView.show(title,message,cancelButtonTitle,nil,nil,nil)

        end

        callback.onFailure = function(a)
            local title = "登录失败"
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
            local title = "登录取消"
            local message = "platform:" .. a.platform
            local cancelButtonTitle = "Sure"
            WADemoLuaAlertView.show(title,message,cancelButtonTitle,nil,nil,nil) 
        end
        return callback
end

function WADemoLoginLayer:ctor()

    self:setNaviTitle("登录")

    local button_1 = ccui.Button:create()

    local flowType = WAUserProxy.getLoginFlowType()
    if flowType == 1 then button_1:setTitleText("登录时不重新绑定设备")
        else button_1:setTitleText("登录时重新绑定设备")
            end
    
    button_1:addClickEventListener(function (event)
        if flowType == 1 
            then
            flowType = 2
            button_1:setTitleText("登录时重新绑定设备")
            else
            flowType = 1
            button_1:setTitleText("登录时不重新绑定设备")
        end
        WAUserProxy.setLoginFlowType(flowType)
    end)


    local button_2 = ccui.Button:create()
    button_2:setTitleText("Facebook登录")
    button_2:addClickEventListener(function (event)
        local callback = self:assembleLoginCallback()
        WAUserProxy.login("FACEBOOK","",callback)
    end)
    local button_3 = ccui.Button:create()
    button_3:setTitleText("Apple登录")
    button_3:addClickEventListener(function (event)
        local callback = self:assembleLoginCallback()
        WAUserProxy.login("APPLE","",callback)
    end)
    local button_4 = ccui.Button:create()
    button_4:setTitleText("VK登录")
    button_4:addClickEventListener(function (event)
        local callback = self:assembleLoginCallback()
        WAUserProxy.login("VK","",callback)
    end)
    local button_5 = ccui.Button:create()
    button_5:setTitleText("访客登录")
    button_5:addClickEventListener(function (event)
        local callback = self:assembleLoginCallback()
        WAUserProxy.login("WINGA","",callback)
    end)
    local button_6 = ccui.Button:create()
    button_6:setTitleText("应用内登录")
    button_6:addClickEventListener(function (event)
        local callback = self:assembleLoginCallback()
        local extInfo = "{\"appUserId\":\"12345\",\"extInfo\":\"extInfo String\",\"appToken\":\"o1akkfjia81FMvFSO8kxC96TgQYlhEEr\",\"appSelfLogin\":true}"
        WAUserProxy.login("WINGA",extInfo,callback)
    end)

    local cacheEnabled = true --缓存登录方式

    local button_7 = ccui.Button:create()
    button_7:setTitleText("登录窗口")
    button_7:addClickEventListener(function (event)
        local callback = self:assembleLoginCallback()
        WAUserProxy.loginUI(cacheEnabled,callback)
    end)

    
    local button_8 = ccui.Button:create()
    if cacheEnabled == true 
        then button_8:setTitleText("缓存登录方式")
        else button_8:setTitleText("不缓存登录方式")
            end

    button_8:addClickEventListener(function (event)
        if cacheEnabled == true 
            then 
            button_8:setTitleText("不缓存登录方式")
            cacheEnabled = false
        else 
            button_8:setTitleText("缓存登录方式")
            cacheEnabled = true
            end
    end)
    local button_9 = ccui.Button:create()
    button_9:setTitleText("登出")
    button_9:addClickEventListener(function (event)
        WAUserProxy.logout()
    end)
    
    


    self:setBtnLayout({button_1,button_2,button_3,button_4,button_5,button_6,button_7,button_8,button_9},{1,2,2,1,2,1})
end 

