wdPrint("slash")

local openGUI = wdGUI.openGUI


-- slash
_G.SLASH_WINDA1 = "/wd"
_G.SLASH_WINDA2 = "/winda"
SlashCmdList["WINDA"] = function(msg)
    if msg == nil or msg == "" then openGUI() end
end

_G.SLASH_RELOADUI1 = "/rl"
SlashCmdList["RELOADUI"] = function (msg)
    ReloadUI()
end


