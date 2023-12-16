wdPrint("slash")

local ReloadUI  = ReloadUI
local openGUI   = wdGUI.openGUI
local openOptions = wdGUI.openOptions 

-- slash
_G.SLASH_WINDA1 = "/wd"
_G.SLASH_WINDA2 = "/winda"
SlashCmdList["WINDA"] = function(msg)
    if msg == nil or msg == "" then 
        openGUI()
        return
    end

    if msg == "opt" or msg == "options" then
        openOptions()
    elseif msg == "help" then
        wdPrint("winda help todo...")
    end
    
end

_G.SLASH_RELOADUI1 = "/rl"
SlashCmdList["RELOADUI"] = function (msg)
    ReloadUI()
end


