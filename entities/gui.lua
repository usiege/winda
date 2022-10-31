-- gui package for slash settings
local _, wd = ...
local unpack, strfind, gsub = unpack, strfind, gsub
local tonumber, pairs, ipairs, next, type, tinsert = tonumber, pairs, ipairs, next, type, table.insert
local Winda, Deploy , L = unpack(wd)

-- winda constant
local DEBUG = DEBUG
local wdConstants = wdConstants


-- Gui refer 
local GuiItemNames = {
    L["MODULE_BAGS"],       --        = "背包"
    L["MODULE_BARS"],       --        = "动作条"
    L["MODULE_BUFF"],       --        = "增/减益"
    L["MODULE_CHAT"],       --        = "聊天框"
    L["MODULE_COMBAT"],     --          = "战斗"
    L["MODULE_MAPS"],       --          = "地图"
    L["MODULE_NAMEPLATE"],  --          = "姓名版"
    L["MODULE_TASK"],       --      = "任务"
    L["MODULE_TOOLTIP"],    --      = "提示"
    L["MODULE_UNITFRAME"],  --      = "头像"
    L["MODULE_SKIN"],       --      = "皮肤"
    L["MODULE_DEPLOY"],     --      = "配置"    
}
local GuiItemIcons = {
    L["MODULE_BAGS_ICON"],
    L["MODULE_BARS_ICON"],
    L["MODULE_BUFF_ICON"], 
    L["MODULE_CHAT_ICON"],
    L["MODULE_COMBAT_ICON"],
    L["MODULE_MAPS_ICON"],
    L["MODULE_NAMEPLATE_ICON"],
    L["MODULE_TASK_ICON"],
    L["MODULE_TOOLTIP_ICON"],
    L["MODULE_UNITFRAME_ICON"],
    L["MODULE_SKIN_ICON"],
    L["MODULE_DEPLOY_ICON"],
}


-- winda settings gui
local GuiFrame      = nil -- gui frame entity
local GuiListFrame  = nil -- gui list frame 
local function init (args)
    -- body...
    if GuiFrame then return GuiFrame end

    -- main frame
    local function initGui() 
        local width = wdConstants.gui_window_width
        local height = wdConstants.gui_window_height
        wdPrint(width, height)

        local f = CreateFrame("Frame", "WindaGUI", UIParent, "BackdropTemplate")
        -- tinsert(UISpecialFrames, "WindaGUI")
        f:SetSize(width, height)
        f:SetFrameLevel(wdConstants.gui_window_level)
        f:SetPoint("CENTER")
        f:SetFrameStrata("HIGH")

        -- bg image blizz api move to
        f:SetBackdrop({
            bgFile = L["GUI_BG_FILE"], -- L["BG_FILE_NORMAL"],
            edgeFile = L["GUI_EDGE_FILE"],
            tile = false,
            tileEdge = false,
            tileSize = 0,
            edgeSize = 3,
            insets = { left = 0, right = 0, top = 0, bottom = 0 }
        })
        -- frame events
        f:SetClampedToScreen(true) -- Prevents a Frame from moving off-screen.
        f:SetMovable(true)
        f:EnableMouse(true)
        f:RegisterForDrag("LeftButton")
        f:SetScript("OnDragStart", function (self)
            self:StartMoving()
        end)
        f:SetScript("OnDragStop", function (self)
            self:StopMovingOrSizing()
        end)

        return f
    end
    GuiFrame = initGui()

    local function initItems(parent)
        -- body
        local itembg = CreateFrame("Frame", "GUIItem", parent, "BackdropTemplate")
        local width = wdConstants.gui_list_width
        local height = wdConstants.gui_list_height
        wdPrint(width, height)
        itembg:SetPoint("LEFT", parent, "LEFT", 0, 0)
        itembg:SetSize(width, height)
        itembg:SetFrameLevel(wdConstants.gui_window_level)
        itembg:SetFrameStrata("HIGH")
        itembg:SetBackdrop({
            bgFile = L["GUI_BG_ITEM"]
        })
        -- items 


        return itembg
    end
    -- item list frame
    GuiListFrame = initItems(GuiFrame)
    
    local function initLogo(parent)
        local frame = CreateFrame("Frame", "GUIItem", parent)
        frame:SetFrameLevel(wdConstants.gui_window_level+1)
        local width = wdConstants.gui_logo_width
        local height = wdConstants.gui_logo_height
        wdPrint(width, height)
        frame:SetPoint("TOP", parent, "TOP", 0, -20)
        frame:SetSize(width, height)
        frame:SetFrameStrata("HIGH")
        -- -- adding a texture
        local texture = frame:CreateTexture(nil, "BACKGROUND")
        texture:SetTexture(L["WINDA_LOGO"])
        texture:SetAllPoints()
        -- mouse event
        frame:SetMouseClickEnabled(true)
        frame:SetScript("OnEnter", function(self, motion) 
            wdPrint("OnEnter", motion) 
        end)
        frame:SetScript("OnLeave", function(self, motion) 
            wdPrint("OnLeave", motion) 
        end)
        frame:SetScript("OnMouseDown", function(self, button) 
            wdPrint("OnMouseDown", button) 
        end)
        frame:SetScript("OnMouseUp", function(self, button) 
            wdPrint("OnMouseUp", button) 
        end)

        return frame
    end
    initLogo(GuiListFrame)



    return GuiFrame
end


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
-- local WEF = Winda.entity


-- global GUI
local GUI = Winda:RegisterEntity("GUI")
do 
    GUI.openGUI = openGUI
    GUI.compenents = {}

end

function GUI: CreateCompnent(index, name)
    print(index, name)


end



function GUI:OnLogin()
    wdPrint("GUI on load")
    if self.entity == nil then
        self.entity = init()
    else
        self.entity = GuiFrame
    end
    self.entity:Hide()
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
