
require "app.uicommon.WADemoListView"
require "app.wasdklua.WACallback"
require "app.uicommon.WADemoLuaAlertView"
require "app.uicommon.WADemoItem"
require "app.wasdklua.WASocialProxy"

WADemoVKGroupList = class("WADemoVKGroupList", function()
    local listView = WADemoListView:new()   
    return listView
end)

function WADemoVKGroupList:ctor()
	self:setTitle("Group List(VK)")
end

function WADemoVKGroupList:queryGroups(type)
    local callback = WACallback:new()
    callback.onSuccess = function(a)
        for i,group in ipairs(a) do
            local item = WADemoItem:new()
            local text = ""
            if group.name ~= nil then text = text .. "name:" .. group.name end
            item:setLableText(text)

            local btnTitle
            if group.is_member == true then btnTitle = "Open"
            else btnTitle = "Join"
            end
            item:setNeedLeftBtn()
            item.leftBtn:setTitleText(btnTitle)
            item.leftBtn:addClickEventListener(function (event)

                local jCallback = WACallback:new()
                jCallback.onSuccess = function(a)
                    local title = "join成功"
                    local message = "onSuccess"
                    local cancelButtonTitle = "Sure"
                    WADemoLuaAlertView.show(title,message,cancelButtonTitle,nil,nil,nil)
                end

                jCallback.onFailure = function(a)
                    local title = "join失败"
                    local message = "onSuccess"
                    local cancelButtonTitle = "Sure"
                    WADemoLuaAlertView.show(title,message,cancelButtonTitle,nil,nil,nil)
                end


               if group.is_member == true then WASocialProxy.openGroupPage("VK", group.screen_name, "")
                else WASocialProxy.joinGroup("VK", group.gid,"",jCallback) end
            end)
            self:addItem(item)
        end

        self:reloadData()
    end

    callback.onFailure = function(a)
        print("查询失败")
    end
    if type == 1 then WASocialProxy.getCurrentAppLinkedGroup("VK","",callback)
    elseif type == 2 then WASocialProxy.getCurrentUserGroup("VK", "",callback)
    elseif type == 3 then WASocialProxy.getGroups("VK","", callback)
    else
        WASocialProxy.getGroupByGid("VK", "124853892,124637113", "",callback)
    end
    
end









