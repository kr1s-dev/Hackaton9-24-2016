-- Require Modules
local moduleRender = require "image_renderer"
local moduleUtil = require "utility"
-- End of Require Modules

-- Variable Declaration
local scene = moduleUtil.storyboard.newScene()
local background
local dialogBox
local text
local screenGroup 
local obsCount = 0
local count = 0
local gamepad = {}
local platforms = {}
-- End of Variable Declaration

-- Start Physics
moduleUtil.physics.start()
moduleUtil.physics.setGravity( 0,9.8)
-- End of Start Physics


-- Function that adds Obstacles
local function createArrayData(name,x,y,width,height)
	print(obsCount)
	obsAtt = {
		name = name, --name of the PNG file
		x = x,
		y = y,
		width = width,
		height = height
	}
	platforms["obs"..obsCount] = moduleRender.allRounder("PL","InGame","obstacles",obsAtt)
	obsCount = obsCount + 1
end
-- End of function

-- Create Scene
function scene:createScene(event)
	screenGroup = self.view
	screenGroup.id = "screen"

	-- Scene Background
	background = moduleRender.allRounder("BG","InGame","backgroundLevel","NA")
	background.alpha = 1
	-- End of Scene Background

	-- Character Setup
	local charRace2Att = {
		name = "charr", --name of the PNG file
		x = display.contentWidth/16,
		y = display.contentHeight - display.contentHeight/2.4,
		width = 46,
		height = 60
	
	}
	race2 = moduleRender.allRounder("CH","Characters","R2",charRace2Att)
	race2.alpha = 1
	-- End of Character Setup

	-- Game Pads
	gamepad = moduleUtil.gamepad()
	-- End of Game Pads

	-- Obstacles

	createArrayData("semilarge_platform",
					display.contentWidth/16,
					display.contentHeight/2 + (display.contentHeight/3),
					display.contentWidth/8,
					display.contentHeight/3)

	createArrayData("small_platform",
					display.contentWidth/2 - (display.contentWidth/3),
					display.contentHeight/1.8,
					display.contentWidth/20,
					display.contentHeight/14)

	createArrayData("holder_log",
					display.contentWidth/2 - (display.contentWidth/7),
					display.contentHeight/2.32,
					display.contentWidth/8,
					display.contentHeight/6)

	createArrayData("mid_platform",
					display.contentWidth/2 - (display.contentWidth/4.5),
					display.contentHeight/2.12,
					display.contentWidth/8,
					display.contentHeight/8)

	createArrayData("log",
					display.contentWidth/2 - (display.contentWidth/7.1),
					display.contentHeight/2.12,
					display.contentWidth/25,
					display.contentHeight/16)

	createArrayData("log",
					display.contentWidth/2 - (display.contentWidth/9.9),
					display.contentHeight/2.1,
					display.contentWidth/25,
					display.contentHeight/16)

	createArrayData("log",
					display.contentWidth/2 - (display.contentWidth/16),
					display.contentHeight/2.06,
					display.contentWidth/25,
					display.contentHeight/16)

	createArrayData("log",
					display.contentWidth - (display.contentWidth/1.91),
					display.contentHeight/2.03,
					display.contentWidth/25,
					display.contentHeight/16)

	createArrayData("log",
					display.contentWidth - (display.contentWidth/2.06),
					display.contentHeight/2.06,
					display.contentWidth/25,
					display.contentHeight/16)

	createArrayData("log",
					display.contentWidth - (display.contentWidth/2.239),
					display.contentHeight/2.1,
					display.contentWidth/25,
					display.contentHeight/16)
	
	createArrayData("log",
					display.contentWidth - (display.contentWidth/2.45),
					display.contentHeight/2.12,
					display.contentWidth/25,
					display.contentHeight/16)

	createArrayData("rightHolder",
					display.contentWidth - (display.contentWidth/2.48),
					display.contentHeight/2.32,
					display.contentWidth/8,
					display.contentHeight/6)
	createArrayData("mid_platform",
					display.contentWidth - (display.contentWidth/3.1),
					display.contentHeight/2.12,
					display.contentWidth/8,
					display.contentHeight/8)

	createArrayData("small_platform",
					display.contentWidth- (display.contentWidth/4.9),
					display.contentHeight/1.8,
					display.contentWidth/20,
					display.contentHeight/14)

	createArrayData("small_platform",
					display.contentWidth- (display.contentWidth/8.3),
					display.contentHeight/1.8,
					display.contentWidth/20,
					display.contentHeight/14)
	-- End of Obstacles

	screenGroup:insert(background)
	screenGroup:insert(gamepad["left"])
	screenGroup:insert(gamepad["right"])
	screenGroup:insert(gamepad["mid"])
	screenGroup:insert(race2)
end
--End of Create Scene

-- Utitlity function
local function scrollThings(self,event)
	self.rotation = 0
	if self.pad == "left"  then   -----right x axis-------
		print(">>"..self.x)
		self.x = self.x - 4
	elseif self.pad == "right"  then   -----right x axis-------
		print(">>"..self.x)
		self.x = self.x + 4
	end
end

local function straight(self,event)
	self.rotation = 0
end

local function walker(event)
	if event.phase == "began" then
	local attribute = {
		width = 46,
		height = 60,
		numFramesInSheet = 3,
		name = "walking",
		start = 1,
		count = 3,
		time = 300,
		loopCount = 0,
		loopDirection = "forward"
	}
	local char = {
	
			{
				x = race2.x,
				y = race2.y
			}
		
		}
		event.target.alpha = 1
	
		if event.target == gamepad["left"] then
			screenGroup:remove(race2)
			race2 = moduleRender.gif("Assets/Characters/R2/Sprite/left.png",attribute,char)
			race2.pad = "left"
			screenGroup:insert(race2)
			moduleUtil.physics.addBody(race2,{friction=50,bounce=0 })
			race2.enterFrame = scrollThings               
			Runtime:addEventListener("enterFrame", race2)
			race2:play()
		elseif event.target == gamepad["right"] then 
			screenGroup:remove(race2)
			race2 = moduleRender.gif("Assets/Characters/R2/Sprite/right.png",attribute,char)
			race2.pad = "right"
			screenGroup:insert(race2)
			moduleUtil.physics.addBody(race2,{friction=0.3,bounce=0 })
			race2.enterFrame = scrollThings               
			Runtime:addEventListener("enterFrame", race2)
			race2:play()
		elseif event.target == gamepad["mid"] then
			--race2.y = race2.y - 100
			transition.to( race2, { time=100,y= race2.y-100})
		
		end
	elseif event.phase == "ended" then
		if event.target == gamepad["right"] or event.target == gamepad["left"]  then
	
		--race2:pause()

		end
		event.target.alpha = 0.5
		Runtime:removeEventListener("enterFrame", race2)
		race2.enterFrame = straight               
		Runtime:addEventListener("enterFrame", race2)
	end
end
-- End of Utility Function


-- Enter Scene
function scene:enterScene(event)
	for i=0,obsCount do
		if platforms["obs"..i] ~= nil and i ~= 2 and i ~=11 then
			moduleUtil.physics.addBody(platforms["obs"..i],"static",{ bounce=0 })
		end
	end
	moduleUtil.physics.addBody(race2,{bounce=0 })
	gamepad["left"]:addEventListener("touch", walker)
	gamepad["right"]:addEventListener("touch", walker)
	gamepad["mid"]:addEventListener("touch", walker)
end
-- End of Enter Scene


-- Exit Scene
function scene:exitScene(event)

end
-- End of Exit Scene


-- Destroy Scene
function scene:destroyScene(event)


end

-- End of Destroy Scene

scene:addEventListener("createScene", scene)
scene:addEventListener("enterScene", scene)
scene:addEventListener("exitScene", scene)
scene:addEventListener("destroyScene", scene)

return scene