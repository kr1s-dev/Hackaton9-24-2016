local util = {}
local myText
local oAWidth = display.contentWidth
local oAHeight = display.contentHeight
local moduleRender = require "image_renderer"
local race2
local gamePadButs= {}
util.physics = require "physics"
util.storyboard = require ("storyboard")

--background
function util.text(message,font)
	
	myText= display.newText( message, 0, 0, native.systemFont,font)
	myText:setReferencePoint(display.CenterReferencePoint)
	myText:setTextColor(0,0,0)
	-- myText.height = oAHeight
	-- myText.width = oAWidth
	myText.x = oAWidth/2
	myText.y = oAHeight - 50
	return myText
end
function util.gamepad(point)
	local leftBut = {
			x = display.contentWidth/23,
			y = display.contentHeight/2 + 83 ,
			width = 30,
			height = 56
	
	}
	local rightBut = {
			x = display.contentWidth/4.5,
			y = display.contentHeight/2 + 83 ,
			width = 30,
			height = 56
	
	}
	local midBut = {
			x = display.contentWidth/2 +(display.contentWidth/2.5) ,
			y = display.contentHeight/2 + 85  ,
			width = 57,
			height = 54
	
	}
	gamePadButs["left"] = moduleRender.allRounder("BT","gamepad","left2",leftBut)
	gamePadButs["right"] = moduleRender.allRounder("BT","gamepad","right2",rightBut)
	gamePadButs["mid"] = moduleRender.allRounder("BT","gamepad","mid",midBut)
	gamePadButs["left"].alpha = 0.5
	gamePadButs["right"].alpha = 0.5
	gamePadButs["mid"].alpha = 0.5

	return gamePadButs
end
return util