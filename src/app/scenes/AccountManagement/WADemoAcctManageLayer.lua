
require "app.uicommon.WADemoNaviLayer"
require "app.wasdklua.WAUserProxy"
require "app.wasdklua.WASocialProxy"
require "app.wasdklua.WACallback"
require "app.uicommon.WADemoLuaAlertView"
require "app.scenes.AccountManagement.WADemoAcctSwitchLayer"
require "app.scenes.AccountManagement.WADemoAcctBoundList"

WADemoAcctManageLayer = class("WADemoAcctManageLayer", function()
    local layer = WADemoNaviLayer:new()   
    return layer
end)

function WADemoAcctManageLayer:assembleResult()
    local callback = WACallback:new()
        callback.onSuccess = function (a)
            local title = "绑定成功"
            local message = "platform:" .. a.platform .. "\nuserId:" .. a.userId .. "\naccessToken:" 
            .. a.accessToken
            local cancelButtonTitle = "Sure"
            WADemoLuaAlertView.show(title,message,cancelButtonTitle,nil,nil,nil)

        end

        callback.onFailure = function(a)
            local title = "绑定失败"
            local message = "platform:" .. a.result.platform
            if a.error.domain ~= nil then message = message .. "\ndomain:" .. a.error.domain end
            if a.error.code ~= nil then message = message  .. "\ncode:" .. a.error.code end
            if a.error.userInfo ~= nil then message = message .. "\nuserInfo:" .. a.error.userInfo end

            local cancelButtonTitle = "Sure"
            WADemoLuaAlertView.show(title,message,cancelButtonTitle,nil,nil,nil) 
        end

        callback.onCancel = function(a)
            local title = "绑定取消"
            local message = "platform:" .. a.platform
            local cancelButtonTitle = "Sure"
            WADemoLuaAlertView.show(title,message,cancelButtonTitle,nil,nil,nil) 
        end
    return callback
end


function WADemoAcctManageLayer:assembleNewAccount()
    local callback = WACallback:new()
        callback.onSuccess = function (a)
            local title = "创建成功"
            local message = "platform:" .. a.platform .. "\nuserId:" .. a.userId .. "\ntoken:" 
            .. a.token .. "\npUserId:" .. a.pUserId .. "\npToken:" .. a.pToken 
            local cancelButtonTitle = "Sure"
            WADemoLuaAlertView.show(title,message,cancelButtonTitle,nil,nil,nil)

        end

        callback.onFailure = function(a)
            local title = "创建失败"
            local message = ""
            if a.error.domain ~= nil then message = message .. "\ndomain:" .. a.error.domain end
            if a.error.code ~= nil then message = message  .. "\ncode:" .. a.error.code end
            if a.error.userInfo ~= nil then message = message .. "\nuserInfo:" .. a.error.userInfo end

            local cancelButtonTitle = "Sure"
            WADemoLuaAlertView.show(title,message,cancelButtonTitle,nil,nil,nil) 
        end

    return callback
end

-- 发送安装事件
function WADemoAcctManageLayer:inviteInstallReward(platform,token)
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


function WADemoAcctManageLayer:ctor()

    self:setNaviTitle("账号管理")

    local button_1 = ccui.Button:create()
    button_1:setTitleText("绑定Facebook账号")
    button_1:addClickEventListener(function (event)
        local callback = self:assembleResult()
        WAUserProxy.bindingAccount("FACEBOOK","",callback)
    end) 




    local button_2 = ccui.Button:create()
    button_2:setTitleText("绑定Apple账号")
    button_2:addClickEventListener(function (event)
        local callback = self:assembleResult()
        WAUserProxy.bindingAccount("APPLE","",callback)
    end)



    local button_3 = ccui.Button:create()
    button_3:setTitleText("绑定VK账号")
    button_3:addClickEventListener(function (event)
        local callback = self:assembleResult()
        WAUserProxy.bindingAccount("VK","",callback)
    end)



    local button_4 = ccui.Button:create()
    button_4:setTitleText("新建账户")
    button_4:addClickEventListener(function (event)
        local callback = self:assembleNewAccount()
        WAUserProxy.createNewAccount(callback)
    end)




    local button_5 = ccui.Button:create()
    button_5:setTitleText("切换账户")
    button_5:addClickEventListener(function (event)
        WADemoAcctSwitchLayer:new():addTo(self):moveIn()
    end)



    local button_6 = ccui.Button:create()
    button_6:setTitleText("查询已绑定账户")
    button_6:addClickEventListener(function (event)
        local acctBoundList = WADemoAcctBoundList:new():addTo(self)
        acctBoundList:moveIn()
    end)




    local button_7 = ccui.Button:create()
    button_7:setTitleText("打开SDK内置账号管理界面")
    button_7:addClickEventListener(function (event)
        local function newAcct(result)
            local title = "新建成功"
            local message = "platform:" .. result.platform .. "\nuserId:" .. result.userId .. "\ntoken:" 
            .. result.token .. "\npUserId:" .. result.pUserId .. "\npToken:" .. result.pToken
            local cancelButtonTitle = "Sure"
            WADemoLuaAlertView.show(title,message,cancelButtonTitle,nil,nil,nil)
        end

        local function switchAcct(result)
            local title = "切换成功"
            local message = "platform:" .. result.platform .. "\nuserId:" .. result.userId .. "\ntoken:" 
            .. result.token .. "\npUserId:" .. result.pUserId .. "\npToken:" .. result.pToken
            local cancelButtonTitle = "Sure"
            WADemoLuaAlertView.show(title,message,cancelButtonTitle,nil,nil,nil)
        end

        local function acctManagerNoti(a)
            
            -- 发送安装事件
            if a.notiType == "bindDidSucceed" then self:inviteInstallReward(a.result.platform,a.result.accessToken) end

            local title = "acctManagerNoti"
            local message = ""
            if a.notiType ~= nil then message = message .. a.notiType end
            local cancelButtonTitle = "Sure"
            WADemoLuaAlertView.show(title,message,cancelButtonTitle,nil,nil,nil)
        end

        WAUserProxy.openAccountManager(newAcct,switchAcct,acctManagerNoti)
    end) 




    local button_8 = ccui.Button:create()
    button_8:setTitleText("获取当前账户信息(VK)")
    button_8:addClickEventListener(function (event)
        local info = WAUserProxy.getAccountInfo("VK")
        if info ~= nil 
            then
            local title = "Account Info"
            local message = ""
            if info.ID ~= nil then message = message .. "ID:" .. info.ID end
            if info.waUserId ~= nil then message = message .. "\nwaUserId:" .. info.waUserId end
            if info.name ~= nil then message = message .. "\nname:" .. info.name end
            if info.pictureURL ~= nil then message = message .. "\npictureURL:" .. info.pictureURL end
            local cancelButtonTitle = "Sure"
            WADemoLuaAlertView.show(title,message,cancelButtonTitle,nil,nil,nil) 
        else
            local title = "Account Info"
            local message = "nil"
            WADemoLuaAlertView.show(title,message,cancelButtonTitle,nil,nil,nil)
        end
    end)

    self:setBtnLayout({button_1,button_2,button_3,button_4,button_5,button_6,button_7,button_8},{2,2,2,1,1})
end
