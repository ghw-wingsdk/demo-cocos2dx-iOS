
require "app.uicommon.WADemoListView"
require "app.scenes.SocialSupport.Gift.WADemoFBFriendList"
require "app.wasdklua.WACallback"
require "app.uicommon.WADemoLuaAlertView"
require "app.uicommon.WADemoItem"
require "app.wasdklua.WASocialProxy"


WADemoFBGiftList = class("WADemoFBGiftList", function()
    local listView = WADemoListView:new()   
    return listView
end)

function WADemoFBGiftList:ctor()
    self:queryFBGraphObjects()
end


function WADemoFBGiftList:queryFBGraphObjects()
    local callback = WACallback:new()
    callback.onSuccess = function(gifts)
        for i,gift in ipairs(gifts) do
            local item = WADemoItem:new()
            item:setLableText(gift.title)
            item:setNeedLeftBtn()
            item.leftBtn:setTitleText("select")
            item.leftBtn:addClickEventListener(function (event)
                local qCallback = WACallback:new()
                qCallback.onSuccess = function(friends)
                    -- 弹出好友列表
                    local freindList = WADemoFBFriendList:new()
                    freindList:displayFriendList(gift,friends,actionType)
                    freindList:addTo(self):setTitle("Freind List(gift:" .. gift.title..")"):moveIn()

                end
                qCallback.onFailure = function(a)
                    print("查询好友失败")
                    local title = "查询好友失败"
                    local message = "domain:" .. a.error.domain .. "\n"
                    message = message .. "code:" .. a.error.code .. "\n"
                    message = message .. "userInfo:" .. a.error.userInfo
                    local cancelButtonTitle = "Sure"
                    WADemoLuaAlertView.show(title,message,cancelButtonTitle,nil,nil,nil)
                end
                WASocialProxy.queryFriends("FACEBOOK",qCallback)
            end)
            self:addItem(item)
        end

        self:reloadData()
    end
    callback.onFailure = function(a)
        local title = "查询礼物列表失败"
        local message = "domain:" .. a.error.domain .. "\n"
        message = message .. "code:" .. a.error.code .. "\n"
        message = message .. "userInfo:" .. a.error.userInfo
        local cancelButtonTitle = "Sure"
        WADemoLuaAlertView.show(title,message,cancelButtonTitle,nil,nil,nil)
    end
    -- 查询商品列表
    WASocialProxy.queryFBGraphObjects("com_ghw_sdk:gift",callback)
end




