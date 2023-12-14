-- gui package for slash settings
local _, wd = ...
local unpack, strfind, gsub = unpack, strfind, gsub
local tonumber, pairs, ipairs, next, type, tinsert = tonumber, pairs, ipairs, next, type, table.insert
local Winda, Deploy , L, DB = unpack(wd)
local addonName = DB.addonName
-- 
local Minimap               = Minimap
-- local GameMenuFrame         = GameMenuFrame
local GameMenuButtonAddons  = GameMenuButtonAddons
local GameMenuButtonLogout  = GameMenuButtonLogout
local InCombatLockdown      = InCombatLockdown
local HideUIPanel           = HideUIPanel
local InterfaceOptions_AddCategory          = InterfaceOptions_AddCategory
local InterfaceOptionsFramePanelContainer   = InterfaceOptionsFramePanelContainer
local InterfaceOptionsFrame_OpenToCategory  = InterfaceOptionsFrame_OpenToCategory

-- winda constant
local DEBUG = DEBUG
local wdConstants = wdConstants

-- Gui refer 
-- show anme icon
local GuiItemDatas = {
    { L["MODULE_ABOUT"], "About", ""},    -- 简介
    
    { L["MODULE_BAGS"],  "Bag", L["MODULE_BAGS_ICON"]},--        = "背包"
    { L["MODULE_BARS"],  "Bar", L["MODULE_BARS_ICON"]}, --        = "动作条"
    { L["MODULE_BUFF"],  "Buff", L["MODULE_BUFF_ICON"]}, --        = "增/减益"
    { L["MODULE_CHAT"],  "Chat", L["MODULE_CHAT_ICON"]}, --        = "聊天框"
    { L["MODULE_NAMEPLATE"], "Nameplate", L["MODULE_NAMEPLATE_ICON"]}, -- "姓名版"
    { L["MODULE_TASK"], "Task", L["MODULE_TASK_ICON"]}, --  "任务"
    { L["MODULE_TOOLTIP"], "Tooltip", L["MODULE_TOOLTIP_ICON"]}, --  "提示"
    { L["MODULE_UNITFRAME"], "Unitframe", L["MODULE_UNITFRAME_ICON"]},      --      = "头像"
    { L["MODULE_SKIN"], "Skin", L["MODULE_SKIN_ICON"]},                --      = "皮肤"

    { L["MODULE_ENABLE"], "Switch", ""},            --          模块开关

    { L["MODULE_DEPLOY"], "Deploy", L["MODULE_DEPLOY_ICON"]}, --      = "配置"  
    { L["MODULE_EXTEND"], "Extend", L["MODULE_DXTEND_ICON"]}, --      = "扩展"  

    { L["MODULE_SEARCH_ING"], "Search", ""}, -- 搜索
    { L["MODULE_COCREATE"], "Cocreate", ""}, -- "温达共创"
}

local GuiItemIcons = {}

-- load
-- winda settings gui
local GUI = Winda:RegisterEntity("GUI")

-- global GUI
do
    -- body
    GUI.entity = nil   
    GUI.minimap = nil
    GUI.options = nil               -- init entity 
    GUI.compenents = {}             -- gui entity foritems
    GUI.titleEntities = {}          -- gui title entities
    GUI.utilityEntity = nil         -- gui bottom entity 
    GUI.interaction = {             -- gui interaction refer to 
        last_index       = 1,
        current_index    = 1,
        buttonArrow      = nil,     -- arrow show current item
    }
end


function GUI:CreateCompnent(index, indexParent, settingItemParent, data)
    wdPrint(index, data)
    local moduleEntity = GuiEntity: new({}, data[2])
    moduleEntity.index_text = data[1] 
    -- left setup 
    moduleEntity:createGuiIndex(index, indexParent)
    -- right setup 
    moduleEntity:createGuiSettingItem(index, settingItemParent)

    -- event
    moduleEntity.index_frame: RegisterForClicks("AnyUp", "AnyDown")
    moduleEntity.index_frame: SetScript("OnClick", function (self, button, down)
        if down then
            GUI.interaction.current_index = index
            if(GUI.interaction.last_index == index) then 
                return
            else
                -- hide last item and show current item
                local lastItem = GUI.compenents[GUI.interaction.last_index]
                lastItem.setting_frame:Hide()
                moduleEntity.setting_frame:Show()
                GUI.interaction.last_index = index

                -- update arrow for item
                local arrow_y = WDC.gui_entity.index_referto_point[2]
                -(index-1)*(WDC.gui_entity.index_button_height+WDC.gui_entity.index_padding_height)
                GUI.interaction.buttonArrow:SetPoint("TOP", 0, arrow_y)
                wdPrint("arrow test")
            end
        else
            wdPrint(index) 
        end
        
    end)
    self.compenents[index] = moduleEntity
end
-- main frame
function GUI:initGui() 
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
        bgFile = "", -- L["BG_FILE_NORMAL"], -- L["GUI_BG_FILE"], -- 
        edgeFile = L["EDGE_NORMAL"],
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
    cf:SetFrameStrata("DIALOG")
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

    -- keys event
    f:SetScript("OnKeyDown", function (self, key)
        if key == "ESCAPE" and self:IsVisible() then
            self:Hide()
        end
    end)

    return f
end

function GUI:initItems(parent)
    -- body
    -- left entity bg frame
    local listbg = CreateFrame("Frame", "GUIEntityBg", parent, "BackdropTemplate")
    local lwidth = WDC.gui_list_width
    local lheight = WDC.gui_list_height
    local pad = WDC.gui_border_pad
    wdPrint(lwidth, lheight)
    
    listbg:SetPoint("TOPLEFT", parent, "TOPLEFT", pad, -pad)
    listbg:SetSize(lwidth, lheight)
    listbg:SetFrameLevel(wdConstants.gui_window_level)
    listbg:SetFrameStrata("HIGH")
    listbg:SetBackdrop({
        bgFile = L["GUI_BG_ITEM"] --L["GUI_SETTING_BG_BLACK"] --L["BG_GRAY_NORMAL"],
    })

    -- right entity bg frame 
    local entitybg = CreateFrame("Frame", "GUIEntityBg", parent, "BackdropTemplate")
    local ewidth = WDC.gui_right_bg_width
    local eheight = WDC.gui_list_height
    wdPrint(ewidth, eheight)
    
    local ex = WDC.gui_border_pad * 2 + WDC.gui_list_width
    entitybg:SetPoint("TOPLEFT", parent, "TOPLEFT", ex, -pad)
    entitybg:SetSize(ewidth, eheight)
    entitybg:SetFrameLevel(wdConstants.gui_window_level)
    entitybg:SetFrameStrata("HIGH")
    entitybg:SetBackdrop({
        bgFile = L["GUI_SETTING_BG_BLACK"], -- L["GUI_SETTING_BG_GREEN"] --L["BG_GRAY_NORMAL"],
    })

    -- items index compenents
    for i,v in ipairs(GuiItemDatas) do
        GUI:CreateCompnent(i, listbg, entitybg, v)
    end
    local firstItem = GUI.compenents[1]
    firstItem.setting_frame:Show()

    -- item arrow
    local arrow_y = WDC.gui_entity.index_referto_point[2]-0*(WDC.gui_entity.index_button_height+WDC.gui_entity.index_padding_height)
    local arrowParent = listbg
    local arrow = firstItem:createImage(arrowParent,
                            {WDC.gui_entity.arrow_width, WDC.gui_entity.arrow_height},
                            {"TOP", arrowParent, "TOP", 0, arrow_y},
                            L["GUI_BUTTON_ARROW"], "DIALOG", "WDItemArrow")
    arrow:Show()
    -- store arrow frame
    self.interaction.buttonArrow = arrow

    -- title frame
    
    -- search frame

    -- bottom frame

    

    return parent, listbg, entitybg
end

function GUI: CreateLogo(parent)
    local frame = CreateFrame("Frame", "GUILogo", parent)
    frame:SetFrameLevel(wdConstants.gui_window_level+1)
    local width, height = wdConstants.gui_logo_width, wdConstants.gui_logo_height
    local x, y = wdConstants.gui_logo_point[1], wdConstants.gui_logo_point[2]
    wdPrint(width, height)
    frame:SetPoint("TOP", parent, "TOP", 0, -y)
    frame:SetSize(width, height)
    frame:SetFrameStrata("HIGH")
    -- -- adding a texture
    local texture = frame:CreateTexture(nil, "BACKGROUND")
    texture:SetTexture(L["WINDA_LOGO_LARGE"])
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

function GUI: CreateVersionText(parent, size, point)
    local frame = CreateFrame("Frame", "GUIVersion", parent)
    frame:SetFrameLevel(wdConstants.gui_window_level+1)
    frame:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", 0, 0)
    frame:SetSize(size.width, size.height)
    frame:SetFrameStrata("HIGH")

    local text = frame:CreateFontString("Version", "OVERLAY", "GameFontWhite")
    text:SetFont(L["FONT_CHINESE"], wdConstants.gui_version_text_size)
    text:SetPoint("BOTTOMRIGHT", 0, 0)
    text:SetWidth(size.width)
    text:SetJustifyH("RIGHT")

    return frame, text
end

-- gui init
local function init(args)
    -- body...
    if GUI.entity then 
        return 
    end

    GUI.entity = GUI:initGui()

    -- items frame
    local guibg, lfbg, rfbg = GUI:initItems(GUI.entity)
    -- logo
    local logo = GUI:CreateLogo(lfbg)
    -- version
    local size = { ["width"] = wdConstants.gui_version_width, ["height"] = wdConstants.gui_version_height}
    local point = { ["x"] = wdConstants.gui_version_point[1], ["y"] = wdConstants.gui_version_point[2]}
    local _, version = GUI:CreateVersionText(logo, size, point)
    version:SetText("v" .. wd.version.string)

end

-- open for gui
local function openGUI(args)
    -- body...
    wdPrint("open or close gui")

    if GUI.entity then
        GUI.entity:Show()
        return
    end

    init()

    GUI.entity:Show()
end

-- esc menu
local function menuWinda() 
    if DEBUG then
        wdPrint("winda menu on load")
    end
    -- body...
    local guimenu = CreateFrame("Button", "GameMenuFrameWinda", GameMenuFrame, 
    "GameMenuButtonTemplate, BackdropTemplate")
	guimenu:SetText(L["Winda Console"])
	guimenu:SetPoint("TOP", GameMenuFrame, "TOP", 0, -35)
	GameMenuFrame:HookScript("OnShow", function(self)
		GameMenuButtonHelp:SetPoint("TOP", guimenu, "BOTTOM", 0, -5)
		self:SetHeight(self:GetHeight() + guimenu:GetHeight() + 15)
	end)
    GameMenuFrame[addonName] = guimenu
	guimenu:SetScript("OnClick", function()
		-- if InCombatLockdown() then
        --     -- UIErrorsFrame:AddMessage(DB.InfoColor..ERR_NOT_IN_COMBAT)
        --     return
        -- end
        if not GUI.entity:IsVisible() then
            openGUI() -- open gui for winda
            HideUIPanel(GameMenuFrame)
        end
	end)
end

-- minimap button icon
local function minimapWinda()
    
    -- 小地图按钮
    local mf = CreateFrame("Button", "MiniMapButtonWinda", Minimap)
    mf:SetWidth(32)
    mf:SetHeight(32)
    mf:SetFrameStrata("LOW")
    mf:Raise()
    mf:SetPoint("TOPLEFT", Minimap, "BOTTOMLEFT", 0, 0)
    mf:SetNormalTexture("Interface\\BUTTONS\\UI-Quickslot-Depress")
    mf:SetHighlightTexture("Interface\\buttons\\iconborder-glowring")

    -- 创建小地图上的图标
    local icon = mf:CreateTexture(nil, "BACKGROUND")
    icon:SetWidth(32)
    icon:SetHeight(32)
    icon:SetPoint("CENTER", mf, "CENTER", 0, 0)
    icon:SetTexture(L["GUI_MINIMAP_ICON"])
    mf.icon = icon

    -- 按钮上的提示
    mf:SetScript("OnEnter", function()
        GameTooltip:SetOwner(mf, "ANCHOR_LEFT")
        GameTooltip:AddLine("|cff1eff00左键:|r 隐藏/显示控制台")
        GameTooltip:Show()
    end)
    mf:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    -- 按钮点击
    mf:SetScript("OnClick", function()
        if GUI.entity:IsShown() then
            GUI.entity:Hide()
            wdPrint("窗口消失")
        else
            GUI.entity:Show()
            wdPrint("窗口出现")
        end
    end)

    GUI.minimap = mf
end

-- system options 
local function optionWinda(args)
    local sf = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer)
    sf:SetScript("OnEvent", function (self, event, loadedAddon)
        if loadedAddon ~= "winda" then return end
    end)
    sf:RegisterEvent("ADDON_LOADED")
    sf:SetScript("OnShow", function (sf)
        -- 显示标题
        local title = sf:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
        title:SetPoint("TOPLEFT", 16, -16)
        title:SetText("winda".." v"..tostring(GetAddOnMetadata("winda", "Version")))
        
        -- 只在显示时加载
        sf:SetScript("OnShow", nil)
    end)
    sf.name = "winda"
    sf:Hide()
    InterfaceOptions_AddCategory(sf)

    GUI.options = sf
end

local function openOpions()
    if GUI.options then
        InterfaceOptionsFrame_OpenToCategory(GUI.options)
        return
    end

    optionWinda()
    InterfaceOptionsFrame_OpenToCategory(GUI.options)
    
end


-- winda frame on global
-- local WEF = Winda.entity
function GUI:OnLogin()
    wdPrint("GUI on load")

    if self.entity then 
        self.entity:Hide()
        return
    end

    init()
    self.entity:Hide()

    -- 1
    menuWinda()

    -- 2 
    minimapWinda()

    -- 3
    optionWinda()
end


-- -- rename from file
-- if _REQUIREDNAME == nil then
--     wdGUI = GUI
-- else
--     _G[_REQUIREDNAME] = GUI
-- end

do 
    GUI.openGUI     = openGUI
    GUI.openOptions = openOpions
    wdGUI = GUI
end
-- package name
return wdGUI
