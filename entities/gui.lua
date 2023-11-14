-- gui package for slash settings
local _, wd = ...
local unpack, strfind, gsub = unpack, strfind, gsub
local tonumber, pairs, ipairs, next, type, tinsert = tonumber, pairs, ipairs, next, type, table.insert
local Winda, Deploy , L, DB = unpack(wd)
local addonName = DB.addonName
-- 
local GameMenuFrame         = GameMenuFrame
local GameMenuButtonAddons  = GameMenuButtonAddons
local GameMenuButtonLogout  = GameMenuButtonLogout
local InCombatLockdown      = InCombatLockdown
local HideUIPanel           = HideUIPanel

-- winda constant
local DEBUG = DEBUG
local wdConstants = wdConstants

-- Gui refer 
local GuiItemDatas = {
    { L["MODULE_ENABLE"], "Switch"},            --          模块开关
    { L["MODULE_BAGS"],  "Bag"},                --        = "背包"
    { L["MODULE_BARS"],  "Bar"},                --        = "动作条"
    { L["MODULE_BUFF"],  "Buff"},               --        = "增/减益"
    { L["MODULE_CHAT"],  "Chat"},               --        = "聊天框"
    { L["MODULE_COMBAT"], "Combat"},            --          = "战斗"
    { L["MODULE_MAPS"], "Map"},                 --          = "地图"
    { L["MODULE_NAMEPLATE"], "Nameplate"},      --          = "姓名版"
    { L["MODULE_TASK"], "Task"},                --      = "任务"
    { L["MODULE_TOOLTIP"], "Tooltip"},          --      = "提示"
    { L["MODULE_UNITFRAME"], "Unitframe"},      --      = "头像"
    { L["MODULE_SKIN"], "Skin"},                --      = "皮肤"
    { L["MODULE_DEPLOY"], "Deploy"},             --      = "配置"  
    { L["MODULE_EXTEND"], "Extend"},             --      = "扩展"  
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
    L["MODULE_DXTEND_ICON"]
}


-- load
-- winda settings gui
local GUI = Winda:RegisterEntity("GUI")
local GuiFrame      = nil -- gui frame entity
-- local GuiListFrame  = nil -- gui list frame 

-- global GUI
do
    -- body
    GUI.compenents = {}             -- gui entitys  
    GUI.interaction = {             -- gui interaction refer to 
        last_index       = 1,
        current_index    = 1,

    }
end
function GUI: CreateCompnent(index, parent, data)
    print(index, data)
    local moduleEntity = GuiEntity: new({}, data[2])
    moduleEntity.index_text = data[1] 
    moduleEntity: createGuiIndex(index, parent)
    moduleEntity: createGuiSettingItem(index, parent:GetParent())

    -- event
    moduleEntity.index_frame: RegisterForClicks("AnyUp", "AnyDown")
    moduleEntity.index_frame: SetScript("OnClick", function (self, button, down)
        if down then
            GUI.interaction.current_index = index
            if(GUI.interaction.last_index == index) then 
                return
            else
                GUI.compenents[GUI.interaction.last_index].setting_frame:Hide()
                moduleEntity.setting_frame: Show()
                GUI.interaction.last_index = index
            end
        else
            print(index) 
        end
        
    end)
    self.compenents[index] = moduleEntity
end
-- main frame
function GUI: initGui() 
    local width = wdConstants.gui_window_width
    local height = wdConstants.gui_window_height
    wdPrint(width, height)

    local f = CreateFrame("Frame", "WindaGUI", UIParent, "BackdropTemplate")
    -- tinsert(UISpecialFrames, "WindaGUI")
    f:SetSize(width, height)
    f:SetFrameLevel(wdConstants.gui_window_level)
    f:SetPoint("CENTER")
    f:SetFrameStrata("HIGH")

    local pad = wdConstants.gui_border_pad
    -- bg image blizz api move to
    f:SetBackdrop({
        bgFile = L["BG_FILE_NORMAL"], -- L["GUI_BG_FILE"], -- 
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        tile = false,
        tileEdge = false,
        tileSize = 0,
        edgeSize = pad,
        insets = { left = pad, right = pad, top = pad, bottom = pad }
    })
    f:SetBackdropBorderColor(0, 0, 0, 1)

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

    -- cancel
    local cf = CreateFrame("Button", nil, f)
    cf:SetPoint("TOPRIGHT",  -5, -5)
    cf:SetSize(20, 20)
    cf:SetFrameStrata("HIGH")
    cf:SetFrameLevel(wdConstants.gui_window_level + 5)
    local texture = cf: CreateTexture(nil, "BACKGROUND")
    texture:SetTexture(L["CANCEL_CLEAR"])
    texture:SetAllPoints()
    cf:RegisterForClicks("AnyUp", "AnyDown")
    cf:SetScript("OnClick", function (self, button, down) 
        if down then
            f:Hide()
        end
    end)
    f.cancel = cf -- outside useful
    f:SetScript("OnKeyDown", function (self, key)
        if key == "ESCAPE" then
            self:Hide()
        end
    end)

    return f
end

function GUI: initItems(parent)
    -- body
    local itembg = CreateFrame("Frame", "GUIItemBg", parent, "BackdropTemplate")
    local width = wdConstants.gui_list_width
    local pad = wdConstants.gui_border_pad
    local height = wdConstants.gui_list_height - 2 * pad
    wdPrint(width, height)
    
    itembg:SetPoint("TOPLEFT", parent, "TOPLEFT", pad, -pad)
    itembg:SetSize(width, height)
    itembg:SetFrameLevel(wdConstants.gui_window_level)
    itembg:SetFrameStrata("HIGH")
    itembg:SetBackdrop({
        bgFile = L["BG_GRAY_NORMAL"], --L["GUI_BG_ITEM"]
    })

    -- items index
    for i,v in ipairs(GuiItemDatas) do
        GUI: CreateCompnent(i, itembg, v)
    end
    GUI.compenents[1].setting_frame:Show()

    
end

function GUI: CreateLogo(parent)
    local frame = CreateFrame("Frame", "GUILogo", parent)
    frame:SetFrameLevel(wdConstants.gui_window_level+1)
    local width, height = wdConstants.gui_logo_width, wdConstants.gui_logo_height
    local x, y = wdConstants.gui_logo_point[1], wdConstants.gui_logo_point[2]
    wdPrint(width, height)
    frame:SetPoint("TOPLEFT", parent, "TOPLEFT", x, -y)
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

local function init (args)
    -- body...
    if GuiFrame then return GuiFrame end

    GuiFrame = GUI: initGui()

    -- item list frame
    GUI: initItems(GuiFrame)
    GUI: CreateLogo(GuiFrame)


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
    local gui = CreateFrame("Button", "GameMenuFrameWinda", GameMenuFrame, "GameMenuButtonTemplate,BackdropTemplate")
	gui:SetText(L["Winda Console"])
	gui:SetPoint("TOP", GameMenuButtonAddons, "BOTTOM", 0, -21)
	GameMenuFrame:HookScript("OnShow", function(self)
		GameMenuButtonLogout:SetPoint("TOP", gui, "BOTTOM", 0, -21)
		self:SetHeight(self:GetHeight() + gui:GetHeight() + 22)
	end)
    GameMenuFrame[addonName] = gui
	gui:SetScript("OnClick", function()
		if InCombatLockdown() then
            -- UIErrorsFrame:AddMessage(DB.InfoColor..ERR_NOT_IN_COMBAT)
            return
        end
		openGUI() -- open gui for winda
		HideUIPanel(GameMenuFrame)
	end)

end


-- winda frame on global
-- local WEF = Winda.entity



do 
    GUI.openGUI = openGUI

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
