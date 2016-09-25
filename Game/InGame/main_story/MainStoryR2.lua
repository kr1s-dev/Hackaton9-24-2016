

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
			name = "charl", --name of the PNG file
			x = display.contentWidth-(display.contentWidth/3),
			y = display.contentHeight/2,
			width = 40,
			height = 40
	
	}
	--black screen
	myRectangle = display.newRect( 0, 0, display.contentWidth,display.contentHeight )
	myRectangle:setFillColor(0,0,0)
	myRectangle.alpha = 0
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
	race2:setStrokeColor(255,0,0)
	race2.strokeWidth = 3
	
	race21 = moduleRender.allRounder("CH","Characters","R2",charRace21Att)
	race21.alpha = 1

	--dialog box
	dialogBox = moduleRender.allRounder("DB","InGame","Dialog","NA")
	--choices
	butChoice1 = moduleRender.allRounder("BT","InGame","but",btnC1Att)
	butChoice1.alpha = 0
	butChoice2 = moduleRender.allRounder("BT","InGame","but",btnC2Att)
	butChoice2.alpha = 0
	
	--text
	question = moduleUtil.text("R2:Who are you? why are you forgering there?",23)
	answerYes = moduleUtil.text("We need to concent our leader regarding sharing this forgering spot,\n we may need to ask you to leave first",14)
	answerYes.y = btnC1Att["y"]
	answerYes.alpha = 0
	answerNo = moduleUtil.text("Leave at once! this is our forging spot!(pushes R1)",14)
	answerNo.y = btnC2Att["y"]
	answerNo.alpha = 0
	


	screenGroup:insert(background3)
	screenGroup:insert(race1)
	screenGroup:insert(race11)
	screenGroup:insert(race2)
	screenGroup:insert(race21)

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
		if event.target == butChoice1 and count == 2 then
			bool = true
			screenGroup:remove(question)
			question = moduleUtil.text("We will just come back here tomorrow",23)
			screenGroup:insert(question)
			race2.strokeWidth = 0
			race1.strokeWidth = 3
			screenGroup:addEventListener( "touch", changeBG )
			butChoice1:removeEventListener( "touch", choice )
			butChoice2:removeEventListener( "touch", choice )
		elseif event.target == butChoice2 and count == 2 then
			bool = false
			screenGroup:remove(question)
			question = moduleUtil.text("R1 goes back to camp and comes back with an army \nand takes over the forging spot from R2",23)
			screenGroup:insert(question)
			race2.strokeWidth = 0
			race1.strokeWidth = 0
			screenGroup:addEventListener( "touch", changeBG )
			butChoice1:removeEventListener( "touch", choice )
			butChoice2:removeEventListener( "touch", choice )
		elseif event.target == butChoice1 and count == 6 then
			bool = true
			screenGroup:remove(question)
			question = moduleUtil.text("ofcourse, we will let our leader know",23)
			screenGroup:insert(question)
			race2.strokeWidth = 0
			race1.strokeWidth = 3
			butChoice1:removeEventListener( "touch", choice )
			butChoice2:removeEventListener( "touch", choice )
			screenGroup:addEventListener( "touch", changeBG )
		elseif event.target == butChoice2 and count == 6 then
			bool = false
			screenGroup:remove(question)
			question = moduleUtil.text("R1 goes back to camp and comes back with an army and\n takes over the forging spot from R2",23)
			screenGroup:insert(question)
			race2.strokeWidth = 0
			race1.strokeWidth = 0
			butChoice1:removeEventListener( "touch", choice )
			butChoice2:removeEventListener( "touch", choice )
			screenGroup:addEventListener( "touch", changeBG )
			print(count)
			print(">>this is")
		end
	
	end

end
function changeBG(event)
	
	if event.phase == "began" then
	count = count+1
	print(count)
		if count == 1 then
			screenGroup:remove(question)
			question = moduleUtil.text("We are the R1 and we just this spot from \nthe other side of the river",23)
			screenGroup:insert(question)
			race2:setStrokeColor(255,0,0)
			race2.strokeWidth = 3
			race2.strokeWidth = 0
			race1:setStrokeColor(255,0,0)
			race1.strokeWidth = 3
		elseif count == 2 then
			answerYes.alpha = 1
			answerNo.alpha = 1
			butChoice1.alpha = 1
			butChoice2.alpha = 1
			butChoice1:addEventListener( "touch", choice )
			butChoice2:addEventListener( "touch", choice )
			screenGroup:removeEventListener( "touch", changeBG )
			question.alpha = 0
			race1.strokeWidth = 0
			race2:setStrokeColor(255,0,0)
			race2.strokeWidth = 3
		elseif count == 4 then
			print(">>>")
				if bool then
					transition.to( myRectangle, { time=500,alpha =1})
					screenGroup:remove(question)
					question = moduleUtil.text("They had a discussion and the leader of R2 would like\n to have a conversation with R1's leader",23)
					screenGroup:insert(question)
				else
					--negative
					transition.to( myRectangle, { time=500,alpha =1})
					screenGroup:remove(question)
					question = moduleUtil.text("R2 goes away from the forging spot",23)
					screenGroup:insert(question)
					--transiton to next lua, adventure
					timer.performWithDelay( 60000, moduleRender.storyboard.gotoScene("Game.InGame.main_story.level1") )
				end
		elseif count == 5 and bool then
			transition.to( myRectangle, { time=500,alpha =0})
			screenGroup:remove(question)
			question = moduleUtil.text("(tomorrow) R1 came back",23)
			screenGroup:insert(question)
			race2.strokeWidth = 0
			race1.strokeWidth = 0
		elseif count == 6 and bool then
			question.alpha = 0
			screenGroup:remove(answerYes)
			screenGroup:remove(answerNo)
			answerYes = moduleUtil.text("our leader would like to speak with you leader regarding what will be the ruling",14)
			answerNo = moduleUtil.text("Go away! We don't want to share this spot with you!(pushes R1)",14)
			screenGroup:insert(answerYes)
			screenGroup:insert(answerNo)
			answerYes.y = btnC1Att["y"]
			answerNo.y = btnC2Att["y"]
			answerYes.alpha = 1
			answerNo.alpha = 1
			butChoice1.alpha = 1
			butChoice2.alpha = 1
			race2.strokeWidth = 3
			race1.strokeWidth = 0
			screenGroup:removeEventListener( "touch", changeBG )
			butChoice1:addEventListener( "touch", choice )
			butChoice2:addEventListener( "touch", choice )
		elseif count == 7 and bool == false then
			transition.to( myRectangle, { time=500,alpha =1})
					screenGroup:remove(question)
					question = moduleUtil.text("R1 goes back to camp and comes back with an army and\n takes over the forging spot from R2",23)
					screenGroup:insert(question)
					
					--transiton to next lua, adventure
		elseif count == 8 then
			if bool then
				race2.strokeWidth = 0
				race1.strokeWidth = 0
				screenGroup:remove(question)
				question = moduleUtil.text("(2 leaders decided to meet and draft the ruling regarding \nsharing of the forgering spot(winnner, screen where 2 leaders meet and draft a ruling)",23)
				screenGroup:insert(question)
				transition.to( myRectangle, { time=500,alpha =1})
				--winner
			else
				screenGroup:remove(question)
				question = moduleUtil.text("R2 goes away from the forging spot",23)
				screenGroup:insert(question)
				--transiton to next lua, adventure
				timer.performWithDelay( 60000, moduleRender.storyboard.gotoScene("Game.InGame.main_story.level1") )
				
			end
			
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



