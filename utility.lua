local util = {}
local myText
local oAWidth = display.contentWidth
local oAHeight = display.contentHeight
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

return util