if DEBUG then
    print("slash")
end

local openGUI = GUI.openGUI


-- slash
_G.SLASH_WINDA1 = "/wd"
_G.SLASH_WINDA2 = "/winda"
_G.SLASH_WINDA3 = "/WD"
SlashCmdList["WINDA"] = function(msg)
    if msg == nil or msg == "" then openGUI() end

end

_G.SLASH_RELOADUI1 = "/rl"
SlashCmdList["RELOADUI"] = ReloadUI