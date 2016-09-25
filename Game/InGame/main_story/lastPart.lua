

local moduleRender = require "image_renderer"
local moduleUtil = require "utility"



local scene = moduleUtil.storyboard.newScene()
local background
local dialogBox
local text
local screenGroup 
local count = 0
local bool
local myRectangle
-- background
	local btnC1Att = {
			x = display.contentWidth/2,
			y = 265,
			width = display.contentWidth - 50,
			height = display.contentHeight/12

		}
	local btnC2Att = {
		x = display.contentWidth/2,
		y = 300,
		width = display.contentWidth - 50,
		height = display.contentHeight/12

	}
function scene:createScene(event)

	screenGroup = self.view
	screenGroup.id = "screen"

	local charRace1Att = {
			name = "mall", --name of the PNG file
			x = display.contentWidth/16,
			y = display.contentHeight/4,
			width = 40,
			height = 40
	
	}
	local charRace11Att = {
			name = "mall", --name of the PNG file
			x = display.contentWidth/4,
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
	local charRace3Att = {
			name = "gaimon", --name of the PNG file
			x = display.contentWidth-(display.contentWidth/3),
			y = display.contentHeight/2,
			width = 40,
			height = 40
	
	}
	--black screen
	myRectangle = display.newRect( 0, 0, display.contentWidth,display.contentHeight )
	myRectangle:setFillColor(0,0,0)
	myRectangle.alpha = 1
	--background image
	--moduleRender.allRounder(type,location,file name,attribute)
	--types:BG = background, CH = character, BT = button, DB = dialogbox
	background3 = moduleRender.allRounder("BG","InGame","forest","NA")
	background3.alpha = 1
	--races(chars)
	race1 = moduleRender.allRounder("CH","Characters","R1",charRace1Att)
	race1.alpha = 1
	race11 = moduleRender.allRounder("CH","Characters","R1",charRace11Att)
	race11.alpha = 1
	race2 = moduleRender.allRounder("CH","Characters","R2",charRace2Att)
	race2.alpha = 1
	race3 = moduleRender.allRounder("CH","Characters","R3",charRace3Att)
	race3.alpha = 1
	--race2:setStrokeColor(255,0,0)
	--race2.strokeWidth = 3

	--dialog box
	dialogBox = moduleRender.allRounder("DB","InGame","Dialog","NA")
	--choices
	butChoice1 = moduleRender.allRounder("BT","InGame","but",btnC1Att)
	butChoice1.alpha = 0
	butChoice2 = moduleRender.allRounder("BT","InGame","but",btnC2Att)
	butChoice2.alpha = 0
	
	--text
	question = moduleUtil.text("after many days later, \nR2 race comes back with another Race(camp of R1)",23)
	answerYes = moduleUtil.text("I'm open to discussion",14)
	answerYes.y = btnC1Att["y"]
	answerYes.alpha = 0
	answerNo = moduleUtil.text("Who are you to demand a discussion. you are in my soil! Sieze them!",14)
	answerNo.y = btnC2Att["y"]
	answerNo.alpha = 0
	


	screenGroup:insert(background3)
	screenGroup:insert(race1)
	screenGroup:insert(race11)
	screenGroup:insert(race2)
	screenGroup:insert(race3)

	screenGroup:insert(myRectangle)
	screenGroup:insert(dialogBox)
	screenGroup:insert(butChoice1)
	screenGroup:insert(butChoice2)
	screenGroup:insert(question)
	screenGroup:insert(answerYes)
	screenGroup:insert(answerNo)
	

end
local function choice(event)
	if event.phase == "began" then
		butChoice1.alpha = 0
		butChoice2.alpha = 0
		answerYes.alpha = 0
		answerNo.alpha = 0
		if event.target == butChoice1 and count == 4 then
			bool = true
			screenGroup:remove(question)
			question = moduleUtil.text("You cannot just take the forging spot because you want to.\n there is another tribe that uses that spot also",18)
			screenGroup:insert(question)
			race2.strokeWidth = 0
			race1.strokeWidth = 0
			race3.strokeWidth = 3
			race11.strokeWidth = 0
			screenGroup:addEventListener( "touch", changeBG )
			butChoice1:removeEventListener( "touch", choice )
			butChoice2:removeEventListener( "touch", choice )
		elseif event.target == butChoice2 and count == 4 then
			bool = false
			myRectangle.alpha = 1
			screenGroup:remove(question)
			question = moduleUtil.text("R3 grouped with R2, \nwith take sheer number. \nthey took on R1 and Won(Game over, war rised and bloodshed all over)",16)
			screenGroup:insert(question)
			race2.strokeWidth = 0
			race1.strokeWidth = 0
			race3.strokeWidth = 0
			race11.strokeWidth = 0
			screenGroup:addEventListener( "touch", changeBG )
			butChoice1:removeEventListener( "touch", choice )
			butChoice2:removeEventListener( "touch", choice )
			
		elseif event.target == butChoice1 and count == 6 then
			bool = false
			myRectangle.alpha = 1
			screenGroup:remove(question)
			question = moduleUtil.text("R1,R2,R3 concluded to draft a ruling for the forging spot(winner!)",16)
			screenGroup:insert(question)
			race2.strokeWidth = 0
			race1.strokeWidth = 0
			race3.strokeWidth = 0
			race11.strokeWidth = 0
			screenGroup:addEventListener( "touch", changeBG )
			butChoice1:removeEventListener( "touch", choice )
			butChoice2:removeEventListener( "touch", choice )
			
		elseif event.target == butChoice2 and count == 6 then
			bool = false
			myRectangle.alpha = 1
			screenGroup:remove(question)
			question = moduleUtil.text("R3 grouped with R2, \nwith take sheer number. \nthey took on R1 and Won(Game over, war rised and bloodshed all over)",16)
			screenGroup:insert(question)
			race2.strokeWidth = 0
			race1.strokeWidth = 0
			race3.strokeWidth = 0
			race11.strokeWidth = 0
			screenGroup:addEventListener( "touch", changeBG )
			butChoice1:removeEventListener( "touch", choice )
			butChoice2:removeEventListener( "touch", choice )
		
		end
	
	end

end
function changeBG(event)
	
	if event.phase == "began" then
	count = count+1
	print(count)
		if count == 1 then
			myRectangle.alpha = 0
			screenGroup:remove(question)
			question = moduleUtil.text("We came here to talk, i need to speak with your leader.",23)
			screenGroup:insert(question)
			race2:setStrokeColor(255,0,0)
			race2.strokeWidth = 0
			race1:setStrokeColor(255,0,0)
			race1.strokeWidth = 0
			race3:setStrokeColor(255,0,0)
			race3.strokeWidth = 3
		elseif count == 2 then
			screenGroup:remove(question)
			question = moduleUtil.text("Who what's to talk to me",23)
			screenGroup:insert(question)
			race2:setStrokeColor(255,0,0)
			race2.strokeWidth = 0
			race1:setStrokeColor(255,0,0)
			race1.strokeWidth = 0
			race11:setStrokeColor(255,0,0)
			race11.strokeWidth = 3
			race3:setStrokeColor(255,0,0)
			race3.strokeWidth = 0
		elseif count == 3 then
			screenGroup:remove(question)
			question = moduleUtil.text("we need to talk about the forging spot,\n you people allegidly took over",23)
			screenGroup:insert(question)
			race2:setStrokeColor(255,0,0)
			race2.strokeWidth = 0
			race1:setStrokeColor(255,0,0)
			race1.strokeWidth = 0
			race11:setStrokeColor(255,0,0)
			race11.strokeWidth = 0
			race3:setStrokeColor(255,0,0)
			race3.strokeWidth = 3
			
		elseif count == 4 then
			question.alpha = 0
			screenGroup:remove(answerYes)
			screenGroup:remove(answerNo)
			answerYes = moduleUtil.text("I'm open to discussion",14)
			answerNo = moduleUtil.text("Who are you to demand a discussion. you are in my soil! Sieze them!",14)
			screenGroup:insert(answerYes)
			screenGroup:insert(answerNo)
			answerYes.y = btnC1Att["y"]
			answerNo.y = btnC2Att["y"]
			answerYes.alpha = 1
			answerNo.alpha = 1
			butChoice1.alpha = 1
			butChoice2.alpha = 1

			race2:setStrokeColor(255,0,0)
			race2.strokeWidth = 0
			race1:setStrokeColor(255,0,0)
			race1.strokeWidth = 
			race11:setStrokeColor(255,0,0)
			race11.strokeWidth = 3
			race3:setStrokeColor(255,0,0)
			race3.strokeWidth = 0
			screenGroup:removeEventListener( "touch", changeBG )
			butChoice1:addEventListener( "touch", choice )
			butChoice2:addEventListener( "touch", choice )
		elseif count == 6 and bool then
		
			question.alpha = 0
			screenGroup:remove(answerYes)
			screenGroup:remove(answerNo)
			answerYes = moduleUtil.text("understand, it was the heat of the moment and anger took place",14)
			answerNo = moduleUtil.text("Who are you to demand a discussion. you are in my soil! Sieze them!",14)
			screenGroup:insert(answerYes)
			screenGroup:insert(answerNo)
			answerYes.y = btnC1Att["y"]
			answerNo.y = btnC2Att["y"]
			answerYes.alpha = 1
			answerNo.alpha = 1
			butChoice1.alpha = 1
			butChoice2.alpha = 1

			race2:setStrokeColor(255,0,0)
			race2.strokeWidth = 0
			race1:setStrokeColor(255,0,0)
			race1.strokeWidth = 
			race11:setStrokeColor(255,0,0)
			race11.strokeWidth = 3
			race3:setStrokeColor(255,0,0)
			race3.strokeWidth = 0
			screenGroup:removeEventListener( "touch", changeBG )
			butChoice1:addEventListener( "touch", choice )
			butChoice2:addEventListener( "touch", choice )
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
	butChoice1:removeEventListener( "touch", choice )
	butChoice2:removeEventListener( "touch", choice )
	screenGroup:removeEventListener( "touch", changeBG )
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



