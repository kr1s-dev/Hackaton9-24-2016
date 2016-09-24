-- Essentail Modules
local moduleRender = require "image_renderer"
local moduleUtil = require "utility"
local scene = moduleUtil.storyboard.newScene()
-- end of modules

-- declare functions to be used in whole class
local racePick
local background
local descDialogBox
local descText
local screenGroup
local dialogBox
local chooseARace
local btnNew
-- end of declarations

function scene:createScene(event)
	print("Enter Scene")
	
	screenGroup = self.view
	-- Frame Background
	background = moduleRender.allRounder("BG","InGame","choose_a_character_bg","N/A")
	-- End of Frame Background

	-- Title Dialog Box
	dialogBox = moduleRender.allRounder("DB","InGame","Dialog","NA")
	dialogBox.x = display.contentWidth/2
	dialogBox.y = display.contentHeight/4
	dialogBox.width = display.contentWidth/1.5
	dialogBox.height = display.contentHeight/6
	-- Text for dialog Box
	text = moduleUtil.text("Pick Your Race")
	text.x = display.contentWidth/2
	text.y = display.contentHeight/4

	-- Descriptive Dialog Box
	descDialogBox = moduleRender.allRounder("DB","InGame","Dialog","NA")
	descDialogBox.alpha = 0
	descText = moduleUtil.text("Pick a Race")
	descText.alpha = 0
	-- End of Dialog Box



	-- Races Attribute
	local charRace1Att = {
			name = "mal", --name of the PNG file
			x = display.contentWidth/3,
			y = display.contentHeight/2,
			width = 60,
			height = 60
	
	}
	local charRace2Att = {
			name = "charf", --name of the PNG file
			x = display.contentWidth-(display.contentWidth/3),
			y = display.contentHeight/2,
			width = 60,
			height = 60
	
	}
	-- End of Races Attribute

	-- Races Available
	race1 = moduleRender.allRounder("CH","Characters","R1",charRace1Att)
	race1.alpha = 1
	race1.id = 'r1'
	race2 = moduleRender.allRounder("CH","Characters","R2",charRace2Att)
	race2.alpha = 1
	race2.id = 'r2'
	-- End of Races Available

	-- Confirm Button
	btnNewAtt = {
		x = display.contentWidth/2,
		y = display.contentHeight - display.contentHeight/3,
		width = 143,
		height = 30
	}
	btnNew = moduleRender.allRounder("BT","","confirm_button",btnNewAtt)
	btnNew.alpha = 0
	-- End of Confirm Race

	screenGroup:insert(background)
	screenGroup:insert(dialogBox)
	screenGroup:insert(text)
	screenGroup:insert(race1)
	screenGroup:insert(race2)
	screenGroup:insert(descDialogBox)
	screenGroup:insert(descText)
	screenGroup:insert(btnNew)
end

local function showRaceDescription(event)
	if event.phase == "began" then
		screenGroup:remove(descText)
		if event.target.id == "r1" then
			descText = moduleUtil.text("A race composing of 100 members")
		else
			descText = moduleUtil.text("A race composing of 30 members")
		end
		screenGroup:insert(descText)
		transition.to( descDialogBox, { time=1000,alpha =1})
		transition.to( btnNew, { time=1000,alpha =1})

	end
end

local function onConfirm(event)
	if event.phase == "began" then
		moduleUtil.storyboard.gotoScene("Game.InGame.intro_story.Story1")
	end
end

function scene:enterScene(event)
	race1:addEventListener( "touch", showRaceDescription )
	race2:addEventListener( "touch", showRaceDescription )
	btnNew:addEventListener( "touch", onConfirm)
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




