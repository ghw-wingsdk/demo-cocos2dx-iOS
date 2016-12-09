
WADemoItem = class("WADemoItem", function()
    local layer = display.newColorLayer(cc.c4b(255, 255, 255, 0)) 
    layer:setPosition(cc.p(0,0))
    layer:setContentSize(display.width,60)
    return layer
end)

function WADemoItem:ctor()
    self.data = {}
end

function WADemoItem:setLableText(text)
    --初始化item的label
    local label = cc.ui.UILabel.new({UILabelType = 2, size = 20 ,text = text , color = cc.c3b(0, 0, 0)})
    label:addTo(self)
    self.label = label

    self:layoutSubview()
end

function WADemoItem:setNeedLeftBtn()
    --初始化leftBtn
    local leftBtn = ccui.Button:create()
    leftBtn:setTouchEnabled(true)
    leftBtn:setScale9Enabled(true)
    leftBtn:setTitleColor(cc.c4b(255, 255, 255, 255))
    leftBtn:setTitleFontSize(25)
    leftBtn:loadTextures("btn_backg_img/btn_backg_3.png", "btn_backg_img/btn_backg_17.png", "")
    leftBtn:addTo(self)
    if self == nil then print("self is nil") end
    self.leftBtn = leftBtn
    self:layoutSubview()
end

function WADemoItem:setNeedBothBtn()
    self:setNeedLeftBtn()
    --初始化rightBtn
    local rightBtn = ccui.Button:create()
    rightBtn:setTouchEnabled(true)
    rightBtn:setScale9Enabled(true)
    rightBtn:setTitleColor(cc.c4b(255, 255, 255, 255))
    rightBtn:setTitleFontSize(25)
    rightBtn:loadTextures("btn_backg_img/btn_backg_3.png", "btn_backg_img/btn_backg_17.png", "")
    rightBtn:addTo(self)
    self.rightBtn = rightBtn


    self:layoutSubview()
end

function WADemoItem:setNeedCheckbox(selectedEvent)  

    --创建复选框         

    local checkBox = ccui.CheckBox:create()

    checkBox:setTouchEnabled(true)

    checkBox:loadTextures("res/icon_box-empty.png",

                "res/icon_box-checked.png",

                "res/icon_box-checked.png",

                "res/icon_box-empty.png",

                "res/icon_box-empty.png")

    
    checkBox:addEventListenerCheckBox(selectedEvent)  --注册事件
    checkBox:addTo(self)
    self.checkBox = checkBox
    self:layoutSubview()
end

function WADemoItem:layoutSubview()


    local x = self.label:getContentSize().width/2 + 20
    local y = self:getContentSize().height/2
    self.label:align(display.CENTER,x,y)

    local layerW = self:getContentSize().width
    local layerH = self:getContentSize().height
    local check_r = 20
    local check_x = self:getContentSize().width - check_r
    local check_y = self:getContentSize().height/2
    if self.checkBox ~= nil then 
        self.checkBox:setPosition(cc.p(check_x, check_y))
    end

    local space = 5
    local btn_r = 20
    if self.checkBox ~= nil then btn_r = self.checkBox:getContentSize().width + check_r + space end 
    local btn_w = 100
    local btn_h = layerH - 2 * space
    local btn_x = layerW - btn_r - btn_w
    local btn_y = space

    local numOfBtn = 0
    if self.leftBtn ~= nil then numOfBtn = numOfBtn + 1 end
    if self.rightBtn ~= nil then numOfBtn = numOfBtn + 1 end

    if numOfBtn == 1 then 
        self.leftBtn:setContentSize(btn_w, btn_h)
        self.leftBtn:align(display.LEFT_BOTTOM,btn_x,btn_y)
    end

    if numOfBtn == 2 then
        self.rightBtn:setContentSize(btn_w, btn_h)
        self.rightBtn:align(display.LEFT_BOTTOM,btn_x,btn_y)
        btn_x = btn_x - space - btn_w
        self.leftBtn:setContentSize(btn_w, btn_h)
        self.leftBtn:align(display.LEFT_BOTTOM,btn_x,btn_y)
    end

end


return WADemoItem