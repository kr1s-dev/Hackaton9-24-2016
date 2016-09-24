local renderer = {}
local bgPath=""
local btnPath=""
local oAWidth = display.contentWidth
local oAHeight = display.contentHeight
local edges = {}
local background
local imageSheet
local gifImage = {}
local btn
renderer.physics = require "physics"
renderer.storyboard = require ("storyboard")
--background
function renderer.allRounder(kind,loc,bG,btnAtt)
	
	Path = "Assets/"..loc.."/"..bG..".png"
	image =display.newImage(Path)

	if kind == "BG" then
		image.height = oAHeight
		image.width = oAWidth
		image.x = oAWidth/2
		image.y = oAHeight/2
	elseif kind == "BT" then
		image:setReferencePoint(display.CenterReferencePoint)
		image.x = btnAtt["x"]
		image.y = btnAtt["y"]
		image.width = btnAtt["width"]
		image.height = btnAtt["height"]
	elseif kind == "DB" then
		image.width = oAWidth
		image.height = 80
		image.x = oAWidth/2
		image.y = oAHeight - 40
	end
	
	return image
end
--boarders
function renderer.borders(borders)
	
	--sets the parameters of the created borders
	for i = 1, table.getn(borders), 1 do
		edges[i] = display.newRect( 0, 0, 0, 0 )
		--display.newRect( [parent,] x, y, width, height )
		if borders[i] == "left" then
			edges[i].width = 5
			edges[i].height = oAHeight
			edges[i].x = 0
			edges[i].y = oAHeight/2
		elseif borders[i] == "right" then
			edges[i].width = 5
			edges[i].height = oAHeight
			edges[i].x = oAWidth
			edges[i].y = oAHeight/2
		elseif borders[i] == "top" then
			edges[i].width = oAWidth
			edges[i].height = 5
			edges[i].x = oAWidth/2
			edges[i].y = 0
		elseif borders[i] == "bottom" then
			edges[i].width = oAWidth
			edges[i].height = 5
			edges[i].x = oAWidth/2
			edges[i].y = oAHeight
		else
		end
	end
	return edges
end

function renderer.gif(location,attribute,portals)

	local options =
		{
			--required parameters
			width = attribute["width"],
			height = attribute["height"],
			numFrames = attribute["numFramesInSheet"]
		}
	local sequenceData =
		{
			name=attribute["name"],
			start=attribute["start"],
			count=attribute["count"],
			time=attribute["time"],
			loopCount = attribute["loopCount"],   -- Optional ; default is 0 (loop indefinitely)
			loopDirection = attribute["loopDirection"]   -- Optional ; values include "forward" or "bounce"
		}	
		print(table.getn(portals))
		print(portals[1].x)
		for i = 1, table.getn(portals), 1 do
			imageSheet = graphics.newImageSheet( location, options )
			gifImage[i] = display.newSprite( imageSheet, sequenceData )
			gifImage.anchorX =0.5 
			gifImage.anchory =0.5 
			gifImage[i].x = portals[i].x
			gifImage[i].y = portals[i].y
			print(portals[i])
		end
	return gifImage
end
return renderer