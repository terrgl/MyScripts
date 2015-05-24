--[[
	Author: Terr
	License: GNU v2
	Zakaz usuwania tej notki.
]]--

addEvent("obiektMagazynier", true)
addEventHandler("obiektMagazynier", root, function()
	local obiekt = createObject(3800,0,0,1)
	setElementData(source, "obiekt", obiekt)
	setElementData(source, "wlasnosc", getPlayerName(source))
	exports.bone_attach:attachElementToBone(obiekt, source, 1,0, 0.5, -0.5, 0, 0, 0)
	setPedAnimation(source, "CARRY", "crry_prtial", 1, true, true, false)
	setObjectScale(obiekt, 0.6)
end)

addEvent("delete_obiektMagazynier", true)
addEventHandler("delete_obiektMagazynier", root, function()
	if getElementData(source, "wlasnosc") == getPlayerName(source) then
		if getElementData(source, "obiekt") then
			local obiekt = getElementData(source, "obiekt")
			destroyElement(obiekt) 
			setPedAnimation(source, false)
		end
	end
end)

addEventHandler("onPlayerQuit", root, function()
	if getElementData(source, "wlasnosc") == getPlayerName(source) then
		if getElementData(source, "obiekt") then
			local obiekt = getElementData(source, "obiekt")
			destroyElement(obiekt)
		end
	end
end)
