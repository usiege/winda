--[[
    lua global api
]]--
string = string
table = table
unpack = unpack
tostring = tostring


--[[
    winda personal api using lua
]]--
function wdStrsplit(delimiter, subject)
    if not subject then return nil end
    local delimiter, fields = delimiter or ":", {}
    local pattern = string.format("([^%s]+)", delimiter)
    string.gsub(subject, pattern, function(c) 
        fields[table.getn(fields)+1] = c 
    end)
    return unpack(fields)
end




--[[
    blizzard global api
]]--

wdPrint("blizz")

-- frame
DEFAULT_CHAT_FRAME = DEFAULT_CHAT_FRAME -- user chat frame default


-- function
ReloadUI            = ReloadUI
ShowUIPanel         = ShowUIPanel
HideUIPanel         = HideUIPanel
UIFrameFadeIn       = UIFrameFadeIn
InCombatLockdown    = InCombatLockdown
GetAddOnMetadata    = GetAddOnMetadata

-- ui
UISpecialFrames         = UISpecialFrames
GameMenuFrame           = GameMenuFrame
GameMenuButtonAddons    = GameMenuButtonAddons
GameMenuButtonLogout    = GameMenuButtonLogout


InterfaceOptionsActionBarsPanelBottomLeft   = InterfaceOptionsActionBarsPanelBottomLeft
InterfaceOptionsActionBarsPanelBottomRight  = InterfaceOptionsActionBarsPanelBottomRight
InterfaceOptionsActionBarsPanelRight        = InterfaceOptionsActionBarsPanelRight
InterfaceOptionsActionBarsPanelRightTwo     = InterfaceOptionsActionBarsPanelRightTwo

-- event 