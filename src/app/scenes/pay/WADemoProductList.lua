
require "app.uicommon.WADemoListView"
require "app.wasdklua.WACallback"
require "app.uicommon.WADemoLuaAlertView"
require "app.uicommon.WADemoItem"
require "app.wasdklua.WAPayProxy"

WADemoProductList = class("WADemoProductList", function()
    local listView = WADemoListView:new()   
    return listView
end)

function WADemoProductList:ctor()
    self:queryInventory()
end


function WADemoProductList:queryInventory()
    local callback = WACallback:new()
    callback.onSuccess = function(products)
        for i,product in ipairs(products) do
            local item = WADemoItem:new()
            item:setLableText(product.productIdentifier)
            item:setNeedLeftBtn()

            item.leftBtn:setTitleText("BUY")
            item.leftBtn:addClickEventListener(function (event)

                local callback = WACallback:new()
                callback.onSuccess = function(a)
                    local title = "购买结果"
                    local message = ""
                    message = message .. "platform:" .. a.platform
                    local resultStr = ""
                    if a.result ~= nil then
                        if a.result.resultCode == 1 then resultStr = "支付成功"
                        elseif a.result.resultCode == 2 then resultStr = "支付失败"
                        elseif a.result.resultCode == 3 then resultStr = "取消"
                        elseif a.result.resultCode == 4 then resultStr = "上报失败"
                        elseif a.result.resultCode == 5 then resultStr = "商品未消耗"
                        elseif a.result.resultCode ==6 then esultStr = "创建订单失败"
                        end
                    else
                        resultStr = "购买失败"
                    end

                    
                    
                    message = message .. "\nresult:" .. resultStr
                    local cancelButtonTitle = "Sure"
                    WADemoLuaAlertView.show(title,message,cancelButtonTitle,nil,nil,nil)
                end
                
                callback.onFailure = function(a)
                    local title = "购买失败"
                    local message = ""
                    message = message .. "platform:" .. a.platform .. "\n"
                    message = "domain:" .. a.error.domain .. "\n"
                    message = message .. "code:" .. a.error.code .. "\n"
                    message = message .. "userInfo:" .. a.error.userInfo
                    local cancelButtonTitle = "Sure"
                    WADemoLuaAlertView.show(title,message,cancelButtonTitle,nil,nil,nil)
                end

                WAPayProxy.payUI(product.productIdentifier,"",callback)

            end)

            
            self:addItem(item)
        end

        self:reloadData()
    end
    callback.onFailure = function(a)
        local title = "查询失败"
        local message = "domain:" .. a.error.domain .. "\n"
        message = message .. "code:" .. a.error.code .. "\n"
        message = message .. "userInfo:" .. a.error.userInfo
        local cancelButtonTitle = "Sure"
        WADemoLuaAlertView.show(title,message,cancelButtonTitle,nil,nil,nil)
    end
    -- 查询商品列表
    WAPayProxy.queryInventory(callback)
end



