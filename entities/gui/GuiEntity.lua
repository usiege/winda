local _, wd = ...
local Winda, Deploy , L = unpack(wd)

-- gui entity
-- gui base entity
GuiEntity = {
    index = 0, -- gui index

    index_frame = nil,    -- gui button frame 
    setting_frame = nil,  -- gui settings frame

    index_text = "",
}
setmetatable(GuiEntity, {__index = BaseEntity})


function GuiEntity: wdPrint()
    wdPrint(self.name)
    if self.entity ~= nil then
        wdPrint("entity name is: "..self.entity.name)
    end
end

function GuiEntity: new(o, name)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    o.name = name
    return o    
end

-- init gui item buttons
function GuiEntity: createGuiIndex(index, parent)
    local frame = CreateFrame("Button", nil, parent)
    frame:SetPoint("TOPLEFT",  
    WDC.gui_entity.index_referto_point[1], 
    WDC.gui_entity.index_referto_point[2] - (WDC.gui_entity.index_button_height + WDC.gui_entity.index_padding_height) * (index - 1))
    frame:SetSize(WDC.gui_entity.index_button_width, 
                  WDC.gui_entity.index_button_height)
    frame:SetFrameStrata("HIGH")

    -- button text
    local fs = frame:CreateFontString(nil, 'OVERLAY')
	fs:SetFont(L["FONT_LANTY"], 12, "OUTLINE")
	fs:SetPoint('CENTER')
	fs:SetText(self.index_text)
	fs:SetJustifyH('CENTER')
	fs:SetTextColor(1, 1, 1, 1)
	frame:SetFontString(fs)

    -- bg image
    wdPrint(self.index_text)
    local texture = frame: CreateTexture(nil, "BACKGROUND")
    texture:SetTexture(L["GUI_BUTTON_BG"])
    texture:SetAllPoints()
    -- wdPrint(self.index_referto_point)

    self.index = index
    self.index_frame = frame
end

-- init item setting frame 
function GuiEntity: createGuiSettingItem(index, parent)
    -- setting
    local frame = CreateFrame("Frame", "", parent, "BackdropTemplate")
    local x,y = -WDC.gui_entity.setting_topright_point[1], 
                -WDC.gui_entity.setting_topright_point[2]
    frame:SetPoint("TOPRIGHT", parent, "TOPRIGHT", x, y)
    frame:SetSize(WDC.gui_entity.setting_item_width, 
                  WDC.gui_entity.setting_item_height)
    frame:SetFrameStrata("HIGH")
    frame:SetBackdrop({
        -- bgFile = L["GUI_SETTING_BG"], --L["GUI_BG_ITEM"]
    })
    frame:Hide()

    -- title
    local tf = CreateFrame("Button", nil, frame)
    tf:SetPoint("TOP",  0, -12)
    tf:SetSize(200, 64)
    tf:SetFrameStrata("HIGH")
    local fs = tf:CreateFontString(nil, 'OVERLAY')
	fs:SetFont(L["FONT_LANTY"], 24, "OUTLINE")
	fs:SetPoint('CENTER')
	fs:SetText(self.index_text)
	fs:SetJustifyH('CENTER')
	fs:SetTextColor(1, 1, 1, 1)
	tf:SetFontString(fs)
    frame.title = tf -- outside useful

    -- store
    self.setting_frame = frame
end