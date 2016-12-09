
WADemoCheckbox = class("WADemoCheckbox", function()
	local layer = cc.Scale9Sprite:create("btn_backg_img/btn_backg_navi2.png")
	layer:setPosition(cc.p(0,0))
    layer:setContentSize(display.width,60)
	return layer
end)

function WADemoCheckbox:ctor()
    
end




return WADemoCheckbox