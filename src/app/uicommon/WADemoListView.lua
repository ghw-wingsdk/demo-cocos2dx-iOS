WADemoListView = class("WADemoListView", function()
	local layer = display.newColorLayer(cc.c4b(255, 255, 255, 255)) 
	layer:setPosition(cc.p(display.width,0))
    layer:setContentSize(display.width,display.height)
    layer:setNodeEventEnabled(true)
	return layer
end)

function WADemoListView:ctor()

	--数据容器
	self.data = {}


	--初始化navi
	local navi = display.newLayer() 
    navi:addTo(self)
    self.navi = navi

    -- navi背景 
    local background_btn = cc.Scale9Sprite:create("btn_backg_img/btn_backg_navi2.png")
	background_btn:addTo(navi) 
	self.background_btn = background_btn

	
    -- 返回按钮
  	local back_btn = ccui.Button:create()
	back_btn:setTouchEnabled(true)
	back_btn:setScale9Enabled(true)
	back_btn:loadTextures("", "", "")
	back_btn:setTitleText(" < BACK")
	back_btn:setTitleFontSize(25)
	back_btn:addClickEventListener(function(event) self:moveOut() end ) 
	back_btn:addTo(background_btn)
	
	self.back_btn = back_btn
	
    --滚动视图
    local contentScrollView = ccui.ScrollView:create()
	contentScrollView:setTouchEnabled(true)
	contentScrollView:addTo(self)
	self.contentScrollView = contentScrollView

	--初始化items
	self.items = {}
	--初始化itemBackgrounds
	self.itemBackgrounds = {}

	self:layoutSubview()

end

--设置navi的title
function WADemoListView:setTitle(title)
	if self.titleLabel ~= nil then self.titleLabel:removeFromParent() end
	local titleLabel = cc.ui.UILabel.new({UILabelType = 2, text = title, size = 30})
	titleLabel:align(display.CENTER,self.navi:getContentSize().width/2,self.navi:getContentSize().height/2)	
	titleLabel:addTo(self.navi)
	self.titleLabel = titleLabel
	return self
end

function WADemoListView:setIsRoot()
	self.back_btn:removeFromParent()
	self:setPosition(cc.p(0,0))
end

-- layer进场动画
function WADemoListView:moveIn()
	local move = cc.MoveTo:create(0.4, cc.p(0,0))
	local move_ease_in = cc.EaseIn:create(move,0.4) --由慢至快（速度线性变化），慢——>快
	local seq = cc.Sequence:create({move_ease_in})  
    seq:setTag(1)
    self:runAction(seq)  
    return self
end

-- layer退场动画
function WADemoListView:moveOut(actionAfterMoveOut)
	local move = cc.MoveTo:create(0.4, cc.p(display.width,0))
	local move_ease_in = cc.EaseIn:create(move,0.4) --由慢至快（速度线性变化），慢——>快 
	--退场动画以及回调函数(将layer从父节点移除)
	local removeFromParent = function ()
	if actionAfterMoveOut ~= nil then actionAfterMoveOut() end
		self:removeFromParent()	
	end

	local seq = cc.Sequence:create({move_ease_in,cc.CallFunc:create(removeFromParent)})
    seq:setTag(2)
    self:runAction(seq)
end


function WADemoListView:setNeedLeftBtn()
	local leftBtn = ccui.Button:create()
	self.leftBtn = leftBtn
	leftBtn:setTouchEnabled(true)
	leftBtn:setScale9Enabled(true)
	leftBtn:setTitleColor(cc.c4b(255, 255, 255, 255))
	leftBtn:setTitleFontSize(25)
	leftBtn:loadTextures("btn_backg_img/btn_backg_2.png", "btn_backg_img/btn_backg_17.png", "")

	leftBtn:addTo(self)

	self:layoutSubview()

end

function WADemoListView:setNeedBothBtn()

	local leftBtn = ccui.Button:create()
	self.leftBtn = leftBtn
	leftBtn:setTouchEnabled(true)
	leftBtn:setScale9Enabled(true)
	leftBtn:setTitleColor(cc.c4b(255, 255, 255, 255))
	leftBtn:setTitleFontSize(25)
	leftBtn:loadTextures("btn_backg_img/btn_backg_2.png", "btn_backg_img/btn_backg_17.png", "")
	leftBtn:addTo(self)


	local rightBtn = ccui.Button:create()
	self.rightBtn = rightBtn
	rightBtn:setTouchEnabled(true)
	rightBtn:setScale9Enabled(true)
	rightBtn:setTitleColor(cc.c4b(255, 255, 255, 255))
	rightBtn:setTitleFontSize(25)
	rightBtn:loadTextures("btn_backg_img/btn_backg_2.png", "btn_backg_img/btn_backg_17.png", "")
	rightBtn:addTo(self)

	self:layoutSubview()

end

function WADemoListView:layoutSubview(isReload)
	
	local navi_x = 0
	local navi_h = display.height/6
	local navi_y = display.height - navi_h
	local navi_w = display.width
	self.navi:setPosition(navi_x,navi_y)
    self.navi:setContentSize(navi_w,navi_h)

    -- navi背景
    self.background_btn:setContentSize(navi_w, navi_h)
	self.background_btn:align(display.LEFT_BOTTOM,0,0)
	self.background_btn:setPosition(cc.p(0,0))

	
    -- 返回按钮
    local back_btn_w = navi_w /6
    local back_btn_h = navi_h
	self.back_btn:setContentSize(back_btn_w, back_btn_h)
	self.back_btn:align(display.LEFT_BOTTOM,0,0)
	self.back_btn:setPosition(cc.p(0,0))

	

	local numOfBtn = 0

	if self.leftBtn ~= nil then numOfBtn = numOfBtn + 1 end
	if self.rightBtn ~= nil then numOfBtn = numOfBtn + 1 end

	local space = 10
	local btn_w = 0
	local btn_h = 50

	if numOfBtn >0 then
		btn_w = (display.width - (numOfBtn + 1) * space)/numOfBtn
	end

	local l_btn_x = space
	local l_btn_y = space
	if self.leftBtn ~= nil then
		self.leftBtn:setContentSize(btn_w, btn_h)
		self.leftBtn:align(display.LEFT_BOTTOM,l_btn_x,l_btn_y)
	end

	local r_btn_x = l_btn_x + btn_w + space
	local r_btn_y = l_btn_y
	if self.rightBtn ~= nil then
		self.rightBtn:setContentSize(btn_w, btn_h)
		self.rightBtn:align(display.LEFT_BOTTOM,r_btn_x,r_btn_y)
	end


	local content_h = 0
	local content_y = 0
	if numOfBtn > 0 
		then 
		content_h = display.height - navi_h - space - btn_h
		content_y = space + btn_h
	else 
		content_h = display.height - navi_h
	end
    local content_w = display.width
    local content_x = 0
    
	self.contentScrollView:setContentSize(content_w, content_h)        
	self.contentScrollView:setPosition(content_x,content_y)
	self.contentScrollView:setInnerContainerSize(cc.size(content_w,content_h))


	--布局item
	local itemW = display.width
	local itemH = 60
	self.itemH = itemH
	local itemX = 0


	-- 计算innerContainerSize
    local totalH = 0
	for i,item in ipairs(self.items) do
		local _itemH = item:getContentSize().height
		if _itemH < itemH then _itemH = itemH end
		totalH = totalH + _itemH
	end

	if totalH > content_h then self.contentScrollView:setInnerContainerSize(cc.size(content_w,totalH))
	else totalH = content_h
	end

	local currentH = 0
	for i,item in ipairs(self.items) do

		local _itemH = item:getContentSize().height
		if _itemH < itemH then _itemH = itemH end 
		currentH = currentH + _itemH

		local itemBackground

		if isReload == nil or isReload == false then 
			 itemBackground = cc.Scale9Sprite:create("btn_backg_img/btn_backg_list_cell.png")	     
		     itemBackground:addTo(self.contentScrollView)
		     table.insert(self.itemBackgrounds,itemBackground)
		     item:addTo(itemBackground)
		else
			itemBackground = self.itemBackgrounds[i]	     			
		end

		itemBackground:setContentSize(itemW,_itemH)
		itemBackground:align(display.LEFT_BOTTOM,0,0)   
		itemBackgroundY = totalH - currentH
		itemBackground:setPosition(cc.p(itemX ,itemBackgroundY))
	end

end


function WADemoListView:addItem(item)	
	table.insert(self.items ,item)
end

function WADemoListView:clearItems()
	-- 清空item
	for i,itemBg in ipairs(self.itemBackgrounds) do
		itemBg:removeFromParent()
	end

	self.items = {}
	self.itemBackgrounds = {}
end

function WADemoListView:reloadData(isReload)
	self:layoutSubview(isReload)
end

function WADemoListView:deleteItem(index)

	local itemBg = self.itemBackgrounds[index]
	if itemBg ~= nil then 
		itemBg:removeFromParent()
		table.remove(self.itemBackgrounds,index)
	end
	table.remove(self.items,index)


	self:reloadData(true)
end











