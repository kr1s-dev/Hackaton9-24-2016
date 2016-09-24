

local moduleRender = require "image_renderer"
local moduleUtil = require "utility"



local scene = moduleUtil.storyboard.newScene()
local background
local dialogBox
local text
local screenGroup 
local count = 0
-- background

function scene:createScene(event)

	screenGroup = self.view
	screenGroup.id = "screen"
	local btnNewAtt = {
			x = display.contentWidth/2,
			y = 200,
			width = 1500,
			height = 50

		}
	local charRace1Att = {
			name = "mall", --name of the PNG file
			x = display.contentWidth/16,
			y = display.contentHeight/4,
			width = 40,
			height = 40
	
	}
	local charRace11Att = {
			name = "mall", --name of the PNG file
			x = display.contentWidth/2,
			y = display.contentHeight/4,
			width = 40,
			height = 40
	
	}
	local charRace2Att = {
			name = "charl", --name of the PNG file
			x = display.contentWidth-(display.contentWidth/6),
			y = display.contentHeight/2,
			width = 40,
			height = 40
	
	}
	local charRace21Att = {
			name = "charr", --name of the PNG file
			x = display.contentWidth-(display.contentWidth/3),
			y = display.contentHeight/2,
			width = 40,
			height = 40
	
	}
	--background image
	--moduleRender.allRounder(type,location,file name,attribute)
	--types:BG = background, CH = character, BT = button, DB = dialogbox
	
	background = moduleRender.allRounder("BG","InGame","island","NA")
	background1 = moduleRender.allRounder("BG","InGame","fields","NA")
	background1.alpha = 0
	--races(chars)
	race1 = moduleRender.allRounder("CH","Characters","R1",charRace1Att)
	race1.alpha = 0
	race11 = moduleRender.allRounder("CH","Characters","R1",charRace11Att)
	race11.alpha = 0
	race2 = moduleRender.allRounder("CH","Characters","R2",charRace2Att)
	race2.alpha = 0
	race21 = moduleRender.allRounder("CH","Characters","R2",charRace21Att)
	race21.alpha = 0
	--dialog box
	dialogBox = moduleRender.allRounder("DB","InGame","Dialog","NA")
	--dialog
	text = moduleUtil.text("There's an Island that's in habited by many races")
	text1 = moduleUtil.text("They each have their own man power,\nR1 having 100 and R2 having 30")
	text1.alpha = 0
	text2 = moduleUtil.text("One day, one of the R1 forgerers saw another location for forgering")
	text2.alpha = 0
	text3 = moduleUtil.text("They decided to go and forge there")
	text3.alpha = 0

	screenGroup:insert(background)
	screenGroup:insert(background1)
	screenGroup:insert(race1)
	screenGroup:insert(race11)
	screenGroup:insert(race2)
	screenGroup:insert(race21)
	screenGroup:insert(dialogBox)
	screenGroup:insert(text)
	screenGroup:insert(text1)
	screenGroup:insert(text3)

end
local function changeBG(event)
	
	if event.phase == "began" then
	count = count+1
	print(count)
		if count == 1 then
			background.alpha =0
			background1.alpha = 1
			race1.alpha = 1
			race11.alpha = 1
			race2.alpha = 1
			race21.alpha = 1
			text.alpha=0
			text1.alpha = 1
		elseif count == 2 then
			background.alpha =0
			background1.alpha = 1
			transition.to( text1, { time=1000,alpha =0})
			transition.to( dialogBox, { time=1000,alpha =0})
			transition.to( background1, { time=8000,alpha =0})
			transition.to( race1, { time=8000,alpha =0})
			transition.to( race11, { time=8000,alpha =0})
			transition.to( race2, { time=8000,alpha =0})
			transition.to( race21, { time=8000,alpha =0})
		else
		
		end
	end
end

function scene:enterScene(event)
	-- physics.addBody( bNew,"static" )
-- btnNew.isBodyActive = false
	--screenGroup:addEventListener("touch", changeBG)

screenGroup:addEventListener( "touch", changeBG )
end

function scene:exitScene(event)

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



