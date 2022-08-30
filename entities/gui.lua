-- gui package for slash settings
local _, wd = ...
local unpack, strfind, gsub = unpack, strfind, gsub
local tonumber, pairs, ipairs, next, type, tinsert = tonumber, pairs, ipairs, next, type, tinsert
local DEBUG = DEBUG
local Winda, Deploy , L = unpack(wd)

local function init (args)
    -- body...
    if f then return f end

    -- main frame
    f = CreateFrame("Frame", "WindaGUI", UIParent)
    tinsert(UISpecialFrames, "WindaGUI")
    f:SetSize(800, 600)
    f:SetPoint("CENTER")
    f:SetFrameStrata("HIGH")
    f:SetFrameLevel(10)



    return f
end

local function openGUI (args)
    -- body...
    if DEBUG then
        print("open gui")
    end
    if f then f:Show() return end

    local f = init()
    f:Show()

end

local function menuWinda ()
    -- body...
    local gui = CreateFrame("Button", "GameMenuFrameWinda", GameMenuFrame, "GameMenuButtonTemplate, BackdropTemplate")
	gui:SetText(L["Winda Console"])
	gui:SetPoint("TOP", GameMenuButtonAddons, "BOTTOM", 0, -21)
	GameMenuFrame:HookScript("OnShow", function(self)
		GameMenuButtonLogout:SetPoint("TOP", gui, "BOTTOM", 0, -21)
		self:SetHeight(self:GetHeight() + gui:GetHeight() + 22)
	end)

	gui:SetScript("OnClick", function()
		if InCombatLockdown() then
            -- UIErrorsFrame:AddMessage(DB.InfoColor..ERR_NOT_IN_COMBAT)
            return
        end
		OpenGUI() -- open gui for winda
		HideUIPanel(GameMenuFrame)
		-- PlaySound(SOUNDKIT.IG_MAINMENU_OPTION)
	end)
end


-- slash
_G.SLASH_WINDA1 = "/wd"
_G.SLASH_WINDA2 = "/winda"
_G.SLASH_WINDA3 = "/WD"
SlashCmdList["WINDA"] = function(msg)
    openGUI(msg)
end

_G.SLASH_RELOADUI1 = "/rl"
SlashCmdList["RELOADUI"] = ReloadUI


-- global GUI
GUI = {
    init = init,
    openGUI = openGUI,
    menuWinda = menuWinda,

}

-- rename from file
if _REQUIREDNAME == nil then
    GUI = GUI
else
    _G[_REQUIREDNAME] = GUI
end

-- package name
return GUI
