

local moduleRender = require "image_renderer"
local moduleUtil = require "utility"



local scene = moduleUtil.storyboard.newScene()
local background
local dialogBox
local text
local screenGroup 
local count = 0
local gamepad = {}
local platforms = {}
moduleUtil.physics.start()
moduleUtil.physics.setGravity( 0,9.8)
-- background
--sadsad
function scene:createScene(event)

	screenGroup = self.view
	screenGroup.id = "screen"

	local charRace2Att = {
			name = "charl", --name of the PNG file
			x = display.contentWidth/2,
			y = display.contentHeight/4,
			width = 46,
			height = 60
	
	}
	local largeObs = {
			name = "semilarge_platform", --name of the PNG file
			x = display.contentWidth/7,
			y = display.contentHeight/2 + (display.contentHeight/3),
			width = 175,
			height = 175
	
	}
	local largeObs2 = {
			name = "semilarge_platform", --name of the PNG file
			x = display.contentWidth,
			y = display.contentHeight/2 + (display.contentHeight/3),
			width = 175,
			height = 175
	
	}
	local smallobs1 = {
			name = "small_platform", --name of the PNG file
			x = display.contentWidth/2 - (display.contentWidth/8),
			y = display.contentHeight/2,
			width = 27,
			height = 25
	
	}
	local smallobs2 = {
			name = "small_platform", --name of the PNG file
			x = display.contentWidth/2,
			y = display.contentHeight/2,
			width = 27,
			height = 25
	
	}
	local smallobs3 = {
			name = "small_platform", --name of the PNG file
			x = display.contentWidth/2 + (display.contentWidth/8),
			y = display.contentHeight/2,
			width = 27,
			height = 25
	
	}
	local smallobs4 = {
			name = "small_platform", --name of the PNG file
			x = display.contentWidth/2 + (display.contentWidth/4),
			y = display.contentHeight/2,
			width = 27,
			height = 25
	
	}

	--background image
	--moduleRender.allRounder(type,location,file name,attribute)
	--types:BG = background, CH = character, BT = button, DB = dialogbox
	background3 = moduleRender.allRounder("BG","InGame","backgroundLevel","NA")
	background3.alpha = 1
	
	--platforms
	platforms["large"] = moduleRender.allRounder("PL","InGame","obstacles",largeObs)
	platforms["larger"] = moduleRender.allRounder("PL","InGame","obstacles",largeObs2)
	platforms["small1"] = moduleRender.allRounder("PL","InGame","obstacles",smallobs1)
	platforms["small2"] = moduleRender.allRounder("PL","InGame","obstacles",smallobs2)
	platforms["small3"] = moduleRender.allRounder("PL","InGame","obstacles",smallobs3)
	platforms["small4"] = moduleRender.allRounder("PL","InGame","obstacles",smallobs4)
	--races(chars)
	race2 = moduleRender.allRounder("CH","Characters","R2",charRace2Att)
	race2.alpha = 1

	--sprites
	--gamepad
	-- to call per part, gamepad["left"],gamepad["right"],gamepad["mid"]
	gamepad = moduleUtil.gamepad()
	

	screenGroup:insert(background3)
	screenGroup:insert(platforms["large"])
	screenGroup:insert(platforms["larger"])
	screenGroup:insert(platforms["small1"])
	screenGroup:insert(platforms["small2"])
	screenGroup:insert(platforms["small3"])
	screenGroup:insert(platforms["small4"])
	screenGroup:insert(gamepad["left"])
	screenGroup:insert(gamepad["right"])
	screenGroup:insert(gamepad["mid"])
	screenGroup:insert(race2)




end
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
		race2:pause()
		end
		event.target.alpha = 0.5
		Runtime:removeEventListener("enterFrame", race2)
		race2.enterFrame = straight               
		Runtime:addEventListener("enterFrame", race2)
	end
end

function scene:enterScene(event)
	-- physics.addBody( bNew,"static" )
-- btnNew.isBodyActive = false
	--screenGroup:addEventListener("touch", walker)
	moduleUtil.physics.addBody(platforms["large"],"static",{bounce=0 })
	moduleUtil.physics.addBody(platforms["larger"],"static",{bounce=0 })
	moduleUtil.physics.addBody(platforms["small1"],"static",{bounce=0 })
	moduleUtil.physics.addBody(platforms["small2"],"static",{bounce=0 })
	moduleUtil.physics.addBody(platforms["small3"],"static",{bounce=0 })
	moduleUtil.physics.addBody(platforms["small4"],"static",{bounce=0 })
	moduleUtil.physics.addBody(race2,{bounce=0 })

	gamepad["left"]:addEventListener("touch", walker)
	gamepad["right"]:addEventListener("touch", walker)
	gamepad["mid"]:addEventListener("touch", walker)
end

function scene:exitScene(event)
	
	Runtime:removeEventListener("enterFrame", race2)
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



