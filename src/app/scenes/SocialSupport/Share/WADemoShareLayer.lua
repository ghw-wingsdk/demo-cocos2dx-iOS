
require "app.uicommon.WADemoNaviLayer"
require "app.wasdklua.WACallback"
require "app.wasdklua.WAUtil"
require "app.wasdklua.WASocialProxy"
require "app.uicommon.WADemoLuaAlertView"
require("src/cocos/cocos2d/json")

WADemoShareLayer = class("WADemoShareLayer", function()
    local layer = WADemoNaviLayer:new()   
    return layer
end)

function WADemoShareLayer:ctor()

    self:setNaviTitle("数据收集")

    local button_1 = ccui.Button:create()
    button_1:setTitleText("PhotoUI")
    button_1:addClickEventListener(function(event)
        self:share(1)        
    end )
    local button_2 = ccui.Button:create()
    button_2:setTitleText("PhotoApi")
    button_2:addClickEventListener(function(event)
        self:share(2)        
    end )
    
    local button_3 = ccui.Button:create()
    button_3:setTitleText("VideoUI")
    button_3:addClickEventListener(function(event)
        self:share(3)        
    end )
    local button_4 = ccui.Button:create()
    button_4:setTitleText("VideoApi")
    button_4:addClickEventListener(function(event)
        self:share(4)        
    end )
    local button_5 = ccui.Button:create()
    button_5:setTitleText("LinkUI")
    button_5:addClickEventListener(function(event)
        self:share(5)        
    end )
    local button_6 = ccui.Button:create()
    button_6:setTitleText("LinkApi")
    button_6:addClickEventListener(function(event)
        self:share(6)        
    end )
    



    self:setBtnLayout({button_1,button_2,button_3,button_4,button_5,button_6},{1,1,1,1,1,1})
end

function WADemoShareLayer:share(type)
    if type == 1 or type == 2 then
        local onSuccess = function(result)
                local resultTab = json.decode(result)
                print("Photo URL" .. resultTab.mediaURL)

                local photo = 
                {
                    imageURL = resultTab.mediaURL,
                    caption = "fill in caption here",
                    userGenerated = true
                }

                local shareContent = 
                {
                    shareType = "photoContent",
                    photos = {photo}
                }

                local callback = self:getCallback()
                
                local shareWithUI = true
                if type == 2 then shareWithUI = false end
                WASocialProxy.share("FACEBOOK",shareContent,shareWithUI,"",callback)
            end

            local onCancel = function()
                print("onCancel")
            end

            local param = {mediaTypes = "public.image",onSuccess = onSuccess ,onCancel = onCancel}

            luaoc.callStaticMethod("WADemoLuaMediaHandler","presentViewController",param)
    
    elseif type == 3 or type == 4 then
        local onSuccess = function(result)
                local resultTab = json.decode(result)
                print("Video URL" .. resultTab.mediaURL)

                local video = 
                {
                    videoURL = resultTab.mediaURL
                }

                local shareContent = 
                {
                    shareType = "videoContent",
                    video = video
                }

                local callback = self:getCallback()
                
                local shareWithUI = true
                if type == 4 then shareWithUI = false end
                WASocialProxy.share("FACEBOOK",shareContent,shareWithUI,"",callback)
            end

            local onCancel = function()
                print("onCancel")
            end

            local param = {mediaTypes = "public.movie",onSuccess = onSuccess ,onCancel = onCancel}

            luaoc.callStaticMethod("WADemoLuaMediaHandler","presentViewController",param)
    else
        local shareContent = 
        {
            shareType = "linkContent",
            contentURL = "https://developers.facebook.com",
            contentTitle = "To share a link to you.",
            contentDescription = "This is a link ,and it links to https://developers.facebook.com",
            imageURL = "http://a5.mzstatic.com/us/r30/Purple3/v4/3a/84/63/3a8463f8-f90d-5e45-7fde-25efaee00b5b/icon175x175.jpeg"
        }

        local callback = self:getCallback()
        
        local shareWithUI = true
        if type == 6 then shareWithUI = false end
        WASocialProxy.share("FACEBOOK",shareContent,shareWithUI,"",callback)
    end

end

function WADemoShareLayer:getCallback()
    local callback = WACallback:new()
    callback.onSuccess = function(a)
        local title = "分享成功"
        local message = "platform:" .. a.platform
    local cancelButtonTitle = "Sure"
    WADemoLuaAlertView.show(title,message,cancelButtonTitle,nil,nil,nil)
    end
    callback.onFailure = function(a)
        local title = "分享失败"
        local message = "platform:" .. a.platform
    local cancelButtonTitle = "Sure"
    WADemoLuaAlertView.show(title,message,cancelButtonTitle,nil,nil,nil)
    end

    callback.onCancel = function(a)
        local title = "分享取消"
        local message = "platform:" .. a.platform
    local cancelButtonTitle = "Sure"
    WADemoLuaAlertView.show(title,message,cancelButtonTitle,nil,nil,nil)
    end
    return callback
end


