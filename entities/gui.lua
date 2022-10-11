-- gui package for slash settings
local _, wd = ...
local unpack, strfind, gsub = unpack, strfind, gsub
local tonumber, pairs, ipairs, next, type, tinsert = tonumber, pairs, ipairs, next, type, table.insert
local Winda, Deploy , L = unpack(wd)

-- winda constant
local DEBUG = DEBUG
local wdConstants = wdConstants






-- winda settings gui
local function init (args)
    -- body...
    if f then return f end

    -- main frame
    f = CreateFrame("Frame", "WindaGUI", UIParent, "BackdropTemplate")
    tinsert(UISpecialFrames, "WindaGUI")
    local width = wdConstants.gui_window_width
    local height = wdConstants.gui_window_height
    print(width, height)
    f:SetSize(width, height)
    f:SetFrameLevel(wdConstants.gui_window_level)
    f:SetPoint("CENTER")
    f:SetFrameStrata("HIGH")

    -- bg image blizz api move to
    f:SetBackdrop({
        bgFile = L["GUI_BG_FILE"],
    	edgeFile = L["GUI_EDGE_FILE"],
    	tile = false,
    	tileEdge = false,
    	tileSize = 0,
    	edgeSize = 3,
    	insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })

    -- -- adding a texture
    -- local texture = f:CreateTexture(nil, "BACKGROUND")
    -- if DEBUG then
    --     --body...
    --     print(L["GUI_BACK_IMAGE"])
    -- end
    -- texture:SetTexture(L["GUI_BACK_IMAGE"])
    -- texture:SetAllPoints()


    return f
end

local GuiFrame = nil -- gui frame entity
local function openGUI (args)
    -- body...
    if DEBUG then
        print("open or close gui")
    end
    if GuiFrame == nil then
        GuiFrame = init()
        GuiFrame:Show()
        return
    end
    if GuiFrame:IsVisible() then
        GuiFrame:Hide()
    else
        GuiFrame:Show()
    end
    -- ShowUIPanel(GuiFrame)
    -- UIFrameFadeIn(GuiFrame, 0.2, 0, 1)
end

local function menuWinda () -- esc menu
    if DEBUG then
        print("winda menu on load")
    end
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
		openGUI() -- open gui for winda
		HideUIPanel(GameMenuFrame)
		-- PlaySound(SOUNDKIT.IG_MAINMENU_OPTION)
	end)
end


-- winda frame on global
local WEF = Winda.entity


-- global GUI
local GUI = Winda:RegisterEntity("GUI")
GUI.openGUI = openGUI

function GUI: CreateEntityButton(entityName)
    print(entityName)
end




function GUI:OnLogin()
    if DEBUG then
        print("GUI on load")
    end
    if self.entity == nil then
        GUI.entity = init()
    else
        GUI.entity = GuiFrame
    end
    menuWinda()
end


-- -- rename from file
-- if _REQUIREDNAME == nil then
--     wdGUI = GUI
-- else
--     _G[_REQUIREDNAME] = GUI
-- end
wdGUI = GUI

-- package name
return wdGUI
