
require "app.uicommon.WADemoNaviLayer"
require "app.wasdklua.WATrackProxy"


WADemoAppTrackingLayer = class("WADemoAppTrackingLayer", function()
    local layer = WADemoNaviLayer:new()   
    return layer
end)

function WADemoAppTrackingLayer:ctor()

    self:setNaviTitle("数据收集")

    local button_1 = ccui.Button:create()
    button_1:setTitleText("Login")
    button_1:addClickEventListener(function (event)
        local event = {eventName = "ghw_login"}
        WATrackProxy.trackEvent(event)
    end)
    local button_2 = ccui.Button:create()
    button_2:setTitleText("initiatedPayment")
    button_2:addClickEventListener(function (event)
        local event = {eventName = "ghw_initiated_payment"}
        WATrackProxy.trackEvent(event)
    end)
    local button_3 = ccui.Button:create()
    button_3:setTitleText("payment")
    button_3:addClickEventListener(function (event)
        local event = 
        {
            eventName = "ghw_payment",
            eventParam = 
            {
                success = true,
                transactionId = "transactionId" , 
                paymentType = 1 ,
                currencyType = "USD",
                currencyAmount = 100,
                virtualCoinAmount = 10,
                virtualCurrency = 10,
                iapId = "iapId",
                iapName = "iapName",
                iapAmount = "iapAmount"
            },
            value = 100
        }
        WATrackProxy.trackEvent(event)
    end)
    local button_4 = ccui.Button:create()
    button_4:setTitleText("initiatedPurchase")
    button_4:addClickEventListener(function (event)
        local event = {eventName = "ghw_initiated_purchase"}
        WATrackProxy.trackEvent(event)
    end)
    local button_5 = ccui.Button:create()
    button_5:setTitleText("purchase")
    button_5:addClickEventListener(function (event)
        local event = 
        {
            eventName = "ghw_purchase",
            eventParam = 
            {
                itemName = "itemName",
                itemAmount = "itemAmount" , 
                price = 100
            },
            value = 100
        }
        WATrackProxy.trackEvent(event)
    end)
    local button_6 = ccui.Button:create()
    button_6:setTitleText("levelAchieve")
    button_6:addClickEventListener(function (event)
        local event = 
        {
            defaultEventName  = "ghw_level_achieved",
            defaultValue = 1,
            defaultParamValues = 
            {
                score = 100 ,
                fighting = 1000 ,
                levelInfo = "levelInfo", 
                levelType = 2 , 
                description = "description"
            },
            eventNameDict = 
            {
                APPSFLYER = "ghw_level_achieved",
                CHARTBOOST = "ghw_level_achieved",
                FACEBOOK = "fb_level_achieved",
                WINGA = "ghw_level_achieved"

            },

            channelSwitcherDict = 
            {
                APPSFLYER = false,
                CHARTBOOST = true,
                FACEBOOK = true,
                WINGA = true
            },

            valueDict = 
            {
                APPSFLYER = 1,
                CHARTBOOST = 1,
                FACEBOOK = 2,
                WINGA = 1
            },

            paramValuesDict = 
            {
                APPSFLYER = 
                {
                    score = 100 ,
                    fighting = 1000 ,
                    levelInfo = "levelInfo", 
                    levelType = 2 , 
                    description = "description"
                },
                CHARTBOOST = 
                {
                    score = 100 ,
                    fighting = 1000 ,
                    levelInfo = "levelInfo", 
                    levelType = 2 , 
                    description = "description"
                },
                FACEBOOK = 
                {
                    score = 100 ,
                    fighting = 1000 ,
                    levelInfo = "fb_levelInfo", 
                    levelType = 2 , 
                    description = "fb_description"
                },
                WINGA = {
                    score = 100 ,
                    fighting = 1000 ,
                    levelInfo = "levelInfo", 
                    levelType = 2 , 
                    description = "description"
                }
            }
        }
        WATrackProxy.trackEventExt(event)
    end)
    local button_7 = ccui.Button:create()
    button_7:setTitleText("userCreate")
    button_7:addClickEventListener(function (event)
        local event = 
        {
            eventName = "ghw_user_create",
            eventParam = 
            {
                roleType = "roleType",
                nickname = "nickname" , 
                gender = 1,
                vip = 10,
                status = 1,
                nickname = "nickname" , 
                registerTime = os.time()*1000,
                bindGameGold = 100,
                gameGold = 1000,
                level = 100,
                fighting = 1000
            },
            value = 100
        }
        WATrackProxy.trackEvent(event)
    end)
    local button_8 = ccui.Button:create()
    button_8:setTitleText("userInfoUpdate")
    button_8:addClickEventListener(function (event)
        local event = 
        {
            eventName = "ghw_user_info_update",
            eventParam = 
            {
                roleType = "roleType",
                nickname = "nickname" , 
                vip = 11
            },
            value = 0
        }
        WATrackProxy.trackEvent(event)
    end)
    local button_9 = ccui.Button:create()
    button_9:setTitleText("goldUpdate")
    button_9:addClickEventListener(function (event)
        local event = 
        {
            eventName = "ghw_gold_update",
            eventParam = 
            {
                approach = "approach",
                goldType = 1 , 
                amount = 10,
                currentAmount = 100
            },
            value = 0
        }
        WATrackProxy.trackEvent(event)
    end)
    local button_10 = ccui.Button:create()
    button_10:setTitleText("taskUpdate")
    button_10:addClickEventListener(function (event)
        local event = 
        {
            eventName = "ghw_task_update",
            eventParam = 
            {
                taskId = "taskId",
                taskName = "taskName" , 
                taskType = "taskType",
                taskStatus = 1
            },
            value = 0
        }
        WATrackProxy.trackEvent(event)
    end)
    local button_11 = ccui.Button:create()
    button_11:setTitleText("userImport")
    button_11:addClickEventListener(function (event)
        local event = 
        {
            eventName = "ghw_user_import",
            value = 0
        }
        WATrackProxy.trackEvent(event)
    end)
    


    self:setBtnLayout({button_1,button_2,button_3,button_4,button_5,button_6,button_7,button_8,button_9,button_10,button_11},{2,2,2,2,2,1})
end


