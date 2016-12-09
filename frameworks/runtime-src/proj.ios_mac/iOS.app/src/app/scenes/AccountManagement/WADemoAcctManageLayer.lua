
require "app.uicommon.WADemoNaviLayer"

WADemoAcctManageLayer = class("WADemoAcctManageLayer", function()
    local layer = WADemoNaviLayer:new()   
    return layer
end)

function WADemoAcctManageLayer:ctor()

    self:setNaviTitle("账号管理")

    local button_1 = ccui.Button:create()
    button_1:setTitleText("绑定Facebook账号")
    local button_2 = ccui.Button:create()
    button_2:setTitleText("绑定Apple账号")
    local button_3 = ccui.Button:create()
    button_3:setTitleText("绑定VK账号")
    local button_4 = ccui.Button:create()
    button_4:setTitleText("新建账户")
    local button_5 = ccui.Button:create()
    button_5:setTitleText("切换账户")
    local button_6 = ccui.Button:create()
    button_6:setTitleText("查询已绑定账户")
    local button_7 = ccui.Button:create()
    button_7:setTitleText("打开SDK内置账号管理界面")
    local button_8 = ccui.Button:create()
    button_8:setTitleText("获取当前账户信息(VK)")


    self:setBtnLayout({button_1,button_2,button_3,button_4,button_5,button_6,button_7,button_8},{2,2,2,1,1})
end


