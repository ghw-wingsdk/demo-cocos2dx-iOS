
require "app.uicommon.WADemoListView"
require "app.wasdklua.WACallback"
require "app.uicommon.WADemoLuaAlertView"
require "app.uicommon.WADemoItem"
require "app.wasdklua.WAUserProxy"

WADemoAcctBoundList = class("WADemoAcctBoundList", function()
    local listView = WADemoListView:new()   
    return listView
end)




function WADemoAcctBoundList:ctor()
    self:queryBoundAccount()
end


function WADemoAcctBoundList:queryBoundAccount()
    local callback = WACallback:new()
        callback.onSuccess = function(result)
            local title = "查询成功"
            local text = ""

            for i,acct in ipairs(result) do
                text = text .. "platform:" .. acct.platform .. "  pUserId:" .. acct.pUserId .. "\n"
                local item = WADemoItem:new()
                item:setLableText(text)
                item:setNeedLeftBtn()
                item.leftBtn:setTitleText("解绑")
                -- 解绑账号
                item.leftBtn:addClickEventListener(function(event)
                    local callback = WACallback:new()
                    callback.onSuccess = function(result)
                        local title = "解绑成功"
                        local message = ""
                        message = message .. "platform:" .. result.platform
                        message = message .. "\npUserId:" .. result.pUserId
                        local cancelButtonTitle = "Sure"
                        WADemoLuaAlertView.show(title,message,cancelButtonTitle,nil,nil,nil)
                    end

                    callback.onFailure = function(a)
                        local title = "解绑失败"
                        local message = "domain:" .. a.error.domain .. "\n"
                        message = message .. "code:" .. a.error.code .. "\n"
                        message = message .. "userInfo:" .. a.error.userInfo
                        local cancelButtonTitle = "Sure"
                        WADemoLuaAlertView.show(title,message,cancelButtonTitle,nil,nil,nil)
                    end


                    WAUserProxy.unBindAccount(acct.platform,acct.pUserId,callback)
                end)
                self:addItem(item)
            end

            self:reloadData()

        end

        callback.onFailure = function (a)
            local title = "查询失败"
            local message = "domain:" .. a.error.domain .. "\n"
            message = message .. "code:" .. a.error.code .. "\n"
            message = message .. "userInfo:" .. a.error.userInfo
            local cancelButtonTitle = "Sure"
            WADemoLuaAlertView.show(title,message,cancelButtonTitle,nil,nil,nil)
        end

        WAUserProxy.queryBoundAccount(callback)
end


