local moduleRender = require "image_renderer"
local moduleUtil = require "utility"
local scene = moduleUtil.storyboard.newScene()
local background
local btnNew
local screenGroup 
-- background

function scene:createScene(event)

	screenGroup = self.view
	local btnNewAtt = {
			x = display.contentWidth/2,
			y = 200,
			width = 143,
			height = 50

		}
	--background image
	background = moduleRender.allRounder("BG","Title Screen","water","NA")
	btnNew = moduleRender.allRounder("BT","Title Screen","btn_NewGame",btnNewAtt)


	screenGroup:insert(background)
	screenGroup:insert(btnNew)


end
local function clickNewGame(event)
	if event.phase == "began" then
		event.target:setFillColor(90)
	elseif event.phase == "ended" then
		event.target:setFillColor(255)
		moduleUtil.storyboard.gotoScene("Game.InGame.intro_story.Story1")
	end
end
function scene:enterScene(event)
	-- physics.addBody( btnNew,"static" )
-- btnNew.isBodyActive = false
	btnNew:addEventListener("touch", clickNewGame)
end

function scene:exitScene(event)

    
	btnNew:removeEventListener("touch", clickNewGame)
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



