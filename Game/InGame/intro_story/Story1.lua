

local moduleRender = require "image_renderer"
local moduleUtil = require "utility"



local scene = moduleUtil.storyboard.newScene()
local background
local dialogBox
local text
-- background

function scene:createScene(event)

	local screenGroup = self.view
	local btnNewAtt = {
			x = display.contentWidth/2,
			y = 200,
			width = 1500,
			height = 50

		}
	--background image
	background = moduleRender.allRounder("BG","InGame","island","NA")
	background1 = moduleRender.allRounder("BG","InGame","fields","NA")
	background1.alpha = 0

	--dialog box
	dialogBox = moduleRender.allRounder("DB","InGame","Dialog","NA")
	--dialog
	text = moduleUtil.text("There's an Island that's in habited by many races")
	text1 = moduleUtil.text("They each have their own man power,\nR1 having 100 and R2 having 30")
	text1.alpha = 0

	screenGroup:insert(background)
	screenGroup:insert(background1)
	screenGroup:insert(dialogBox)
	screenGroup:insert(text)

end
local function changeBG(event)

	if event.phase == "ended" then
		event.target:setFillColor(255)
		background.alpha =0
		background1.alpha = 1
		text.alpha = 0
		text1.alpha =1
	end
end
local function changeBG1(event)
	if event.phase == "ended" then
		background.alpha =0
		background1.alpha = 1
		transition.to( text1, { time=1000,alpha =0})
		transition.to( dialogBox, { time=1000,alpha =0})
		transition.to( background1, { time=10000,alpha =0})
	end	
end

function scene:enterScene(event)
	-- physics.addBody( bNew,"static" )
-- btnNew.isBodyActive = false
	background:addEventListener("touch", changeBG)
	background1:addEventListener("touch", changeBG1)
end

function scene:exitScene(event)

    
	background:removeEventListener("touch", changeBG)
	screenGroup:removeSelf()
	screenGroup=nil

end

function scene:destroyScene(event)


end

scene:addEventListener("createScene", scene)
scene:addEventListener("enterScene", scene)
scene:addEventListener("exitScene", scene)
scene:addEventListener("destroyScene", scene)

return scene



