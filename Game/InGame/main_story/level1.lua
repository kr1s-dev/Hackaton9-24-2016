

local moduleRender = require "image_renderer"
local moduleUtil = require "utility"



local scene = moduleUtil.storyboard.newScene()
local background
local dialogBox
local text
local screenGroup 
local count = 0
-- background
--sadsad
function scene:createScene(event)

	screenGroup = self.view
	screenGroup.id = "screen"
	local btnC1Att = {
			x = display.contentWidth/2,
			y = 265,
			width = display.contentWidth - 50,
			height = display.contentHeight/12

		}

	local charRace2Att = {
			name = "charl", --name of the PNG file
			x = display.contentWidth/16,
			y = display.contentHeight/4,
			width = 40,
			height = 40
	
	}
	local charRace21Att = {
			name = "charr", --name of the PNG file
			x = display.contentWidth/2,
			y = display.contentHeight/4,
			width = 40,
			height = 40
	
	}


	--background image
	--moduleRender.allRounder(type,location,file name,attribute)
	--types:BG = background, CH = character, BT = button, DB = dialogbox
	background3 = moduleRender.allRounder("BG","InGame","backgroundLevel","NA")
	background3.alpha = 1
	--races(chars)
	race2 = moduleRender.allRounder("CH","Characters","R2",charRace2Att)
	race2.alpha = 1
	race21 = moduleRender.allRounder("CH","Characters","R2",charRace21Att)
	race21.alpha = 1
	--sprites
	--gamepad
	leftKey = 
	


	screenGroup:insert(background3)
	screenGroup:insert(race2)
	screenGroup:insert(race21)



end
local function choice(event)
print(event.target.name)
end
local function changeBG(event)
	
	if event.phase == "began" then
	count = count+1
	print(count)
		if count == 1 then
			question.alpha=0
			answerYes.alpha=1
			answerNo.alpha=1
			butChoice2.alpha=1
			butChoice1.alpha=1
			race2.strokeWidth = 0
			race1:setStrokeColor(255,0,0)
			race1.strokeWidth = 3
			screenGroup:removeEventListener( "touch", changeBG )
			butChoice1:addEventListener( "touch", choice )
			butChoice2:addEventListener( "touch", choice )
		elseif count == 2 then
			background.alpha =0
			background1.alpha = 1
			--1000 for all, 1 for testing time
			transition.to( text1, { time=1,alpha =0})
			--transition.to( background1, { time=8000,alpha =0, onComplete=bgShower } )
			--8000 for all, 1 for testing time
			transition.to( background1, { time=1,alpha =0, onComplete=bgShower } )
			transition.to( race1, { time=1,alpha =0})
			transition.to( race11, { time=1,alpha =0})
			transition.to( race2, { time=1,alpha =0})
			transition.to( race21, { time=1,alpha =0})
		elseif count == 3 then
			text2.alpha = 0
			background2.alpha = 0
			race13.alpha = 0
			text3.alpha = 1
			background3.alpha = 1
			race1.alpha = 1
			race11.alpha = 1
		elseif count == 4 then--toper's race chooser
			moduleUtil.storyboard.gotoScene()
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



