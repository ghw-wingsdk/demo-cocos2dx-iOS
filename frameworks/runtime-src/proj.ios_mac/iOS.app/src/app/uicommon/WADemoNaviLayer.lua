
WADemoNaviLayer = class("WADemoNaviLayer", function()
	local layer = display.newColorLayer(cc.c4b(255, 255, 255, 255)) 
	layer:setPosition(cc.p(display.width,0))
    layer:setContentSize(display.width,display.height)
	return layer
end)

function WADemoNaviLayer:ctor()

	-- 背景精灵
	local background = cc.Scale9Sprite:create("main_backg.jpg")
	background:setContentSize(display.width,display.height)
	background:align(display.LEFT_BOTTOM,0,0)
	background:setPosition(cc.p(0,0))
	background:addTo(self)



	--初始化navi

	local navi_x = 0
	local navi_h = display.height/6
	local navi_y = display.height - navi_h
	local navi_w = display.width
	local navi = display.newLayer() 
	navi:setPosition(navi_x,navi_y)
    navi:setContentSize(navi_w,navi_h)
    navi:addTo(self)
    self.navi = navi

    -- navi背景
    local background_btn = cc.Scale9Sprite:create("btn_backg_img/btn_backg_navi2.png")
    background_btn:setContentSize(navi_w, navi_h)
	background_btn:align(display.LEFT_BOTTOM,0,0)
	background_btn:setPosition(cc.p(0,0))
	background_btn:addTo(navi) 

	
    -- 返回按钮
    local back_btn_w = navi_w /6
    local back_btn_h = navi_h
  	local back_btn = ccui.Button:create()
	back_btn:setContentSize(back_btn_w, back_btn_h)
	back_btn:align(display.LEFT_BOTTOM,0,0)
	back_btn:setPosition(cc.p(0,0))
	back_btn:setTouchEnabled(true)
	back_btn:setScale9Enabled(true)
	back_btn:loadTextures("", "", "")
	back_btn:setTitleText(" < BACK")
	back_btn:setTitleFontSize(25)
	back_btn:addClickEventListener(function(event) self:moveOut() end ) 
	back_btn:addTo(background_btn)
	
	self.back_btn = back_btn
	

    local content_h = display.height - navi_h
    local content_w = display.width
    local content_x = 0
    local content_y = 0
    local contentScrollView = ccui.ScrollView:create()
	contentScrollView:setTouchEnabled(true)
	contentScrollView:setContentSize(content_w, content_h)        
	contentScrollView:setPosition(content_x,content_y)
	contentScrollView:addTo(self)
	self.contentScrollView = contentScrollView

end

--设置navi的title
function WADemoNaviLayer:setNaviTitle(title)
	local naviTitleLabel = cc.ui.UILabel.new({UILabelType = 2, text = title, size = 30})
	naviTitleLabel:align(display.CENTER,self.navi:getContentSize().width/2,self.navi:getContentSize().height/2)	
	naviTitleLabel:addTo(self.navi)
end

function WADemoNaviLayer:setIsRoot()
	self.back_btn:removeFromParent()
	self:setPosition(cc.p(0,0))
end

-- layer进场动画
function WADemoNaviLayer:moveIn()
	local move = cc.MoveTo:create(0.4, cc.p(0,0))
	local move_ease_in = cc.EaseIn:create(move,0.4) --由慢至快（速度线性变化），慢——>快
	local seq = cc.Sequence:create({move_ease_in})  
    seq:setTag(1)
    self:runAction(seq)  
end

-- layer退场动画
function WADemoNaviLayer:moveOut()
	local move = cc.MoveTo:create(0.4, cc.p(display.width,0))
	local move_ease_in = cc.EaseIn:create(move,0.4) --由慢至快（速度线性变化），慢——>快 
	--退场动画以及回调函数(将layer从父节点移除)
	local removeFromParent = function ()
		self:removeFromParent()
	end
	local seq = cc.Sequence:create({move_ease_in,cc.CallFunc:create(removeFromParent)})
    seq:setTag(2)
    self:runAction(seq)
end

function WADemoNaviLayer:setBtnLayout(btns,layout)

	
	local bottom = 20
	local space = 20
	local height = 50
	local left = 20
	local right = 20

	
	--计算contentScrollView的高度
	local numOfLine = table.getn(layout)	
	local scroolV_h = self.contentScrollView:getContentSize().height
	local scroolV_w = self.contentScrollView:getContentSize().width
	local scroolV_h_inner = numOfLine * (height + space) + bottom;

	local scroolV_h_inner_final = ((scroolV_h < scroolV_h_inner) and scroolV_h_inner) or scroolV_h
	self.contentScrollView:setInnerContainerSize(cc.size(scroolV_w,scroolV_h_inner_final))

	local top = scroolV_h_inner_final - 20
	
	local numOfBtn = table.getn(btns)
	
	local index = 0
	--遍历btns在界面上布局
	for line,num in ipairs(layout) do
		if num > 0
			then
				local width = (scroolV_w - left - right -(num - 1) * space)/num
				for i=1,num do
					local x = left + ((i - 1)%num)*(space + width)
					local y = top - (line - 1) * (height + space)
					index = index + 1
					if index < numOfBtn + 1
						then 
						local btn = btns[index]
						btn:setContentSize(width, height)
						btn:align(display.LEFT_TOP,x,y)
						btn:setTouchEnabled(true)
						btn:setScale9Enabled(true)
						btn:setTitleColor(cc.c4b(0, 0, 0, 255))
						btn:setTitleFontSize(25)
						btn:loadTextures("btn_backg_img/btn_backg_3.png", "btn_backg_img/btn_backg_17.png", "")
						btn:addTo(self.contentScrollView)
					end
				end
			end
		
	end

end

return WADemoNaviLayer