--[[
	Author: Terr
	License: GNU v2
	Zakaz usuwania tej notki.
]]--

local jobPoints = {
{-1267.96, 2734.17, 50.10},
{-1258.07, 2718.28, 50.10},
{-1268.22, 2730.54, 50.10},
{-1260.36, 2719.89, 50.10},
{-1262.46, 2715.74, 50.10},
{-1273.58, 2730.91, 50.10},
{-1268.06, 2712.52, 50.10},
{-1279.14, 2727.72, 50.10},
}

local x,y,z=-1282.31, 2705.07, 49.10 -- pozycja gdzie ma stać marker

local jobMarker
local jobStartMarker=createMarker(x,y,z, "cylinder", 4, 0, 0, 255)
local jobStartBlip=createBlipAttachedTo(jobStartMarker, 52)

function finishJob()
	if jobMarker and isElement(jobMarker) then
		destroyElement(jobMarker)
		jobMarker=nil
	end
	if jobTarget and isElement(jobTarget) then
		destroyElement(jobTarget)
		jobTarget=nil
	end
end

local function showMarker()
	rnd=math.random(1, #jobPoints)
	jobMarker=createMarker(jobPoints[rnd][1], jobPoints[rnd][2], jobPoints[rnd][3], "checkpoint", 1, 0, 0, 255)
	
	addEventHandler("onClientMarkerHit", jobMarker, function()
		if el~=localPlayer or not md then return end
		if not getPedOccupiedVehicle(el) then
			setElementFrozen(el, true)
			outputChatBox("* Kładziesz karton na regale.")
			setTimer(function()
				finishJob()
				playSoundFrontEnd(1)
				setElementFrozen(el, false)
				toggleControl("jump", true)
				toggleControl("sprint", true)
				toggleControl("enter_exit", true)
				setElementData(el, "player_job", false)
				triggerServerEvent("givePlayerMoney", resourceRoot, 3)
				triggerServerEvent("delete_obiektMagazynier", el)
			end, 5000, 1)
		end
	end)
end

bindKey("e", "down", function()
	if isElementWithinMarker(localPlayer, jobStartMarker) then
		if not getElementData(localPlayer, "player_job") then
			--[[if getPlayerName(localPlayer) ~= "Terr" then
				outputChatBox("* Praca w trakcie poprawek.")
				return
			end]]
			outputChatBox("* Odnieś karton na wybrane miejsce.", 0, 128, 0)
			triggerServerEvent("obiektMagazynier", localPlayer)
			setElementData(localPlayer, "player_job", true)
			toggleControl("enter_exit", false)
			toggleControl("sprint", false)
			toggleControl("jump", false)
			showMarker()
		else
			outputChatBox("* Już posiadasz aktywną pracę.", 255, 0, 0)
		end
	end
end)
