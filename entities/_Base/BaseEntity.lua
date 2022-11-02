local _, wd = ...
local Winda, Deploy , L = unpack(wd)

-- module base entity 
-- entity is winda global module 
-- module's entity is frame which create by Blizz API
BaseEntity = {
    name = "BaseEntity",
    entity = nil,  -- a frame create by blizz api

}
setmetatable(BaseEntity, {__index = BaseEntity})
BaseEntity.__index = BaseEntity

-- BaseEntity: createButton



-- gui base entity
GuiEntity = {
    index = 0, -- gui index

    index_frame = nil,  -- gui button frame 
    setting_frame = nil, -- gui settings frame

    index_text = "",
    index_referto_point     = {10, -88},
    index_padding_height    = 8,
    index_button_width      = 180,
    index_button_height     = 32,

    setting_item_width      = 800,
    setting_item_height     = 750,
    setting_topright_point  = {0, 0},
}
setmetatable(GuiEntity, {__index = BaseEntity})


function GuiEntity: print()
    print(self.name)
    if self.entity ~= nil then
        print("entity name is: "..self.entity.name)
    end
end

function GuiEntity: new(o, name)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    o.name = name
    return o    
end

function GuiEntity: createGuiIndex(index, parent)
    local frame = CreateFrame("Button", nil, parent)
    frame:SetPoint("TOPLEFT",  self.index_referto_point[1], 
    self.index_referto_point[2] - (self.index_button_height + self.index_padding_height) * (index - 1))
    frame:SetSize(self.index_button_width, self.index_button_height)
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
    -- print(self.index_referto_point)

    self.index = index
    self.index_frame = frame
end

function GuiEntity: createGuiSettingItem(index, parent)
    -- setting
    local frame = CreateFrame("Frame", "", parent, "BackdropTemplate")
    local x,y = -self.setting_topright_point[1], -self.setting_topright_point[2]
    frame:SetPoint("TOPRIGHT", parent, "TOPRIGHT", x, y)
    frame:SetSize(self.setting_item_width, self.setting_item_height)
    frame:SetFrameStrata("HIGH")
    frame:SetBackdrop({
        -- bgFile = L["GUI_SETTING_BG"], --L["GUI_BG_ITEM"]
    })
    frame:Hide()

    -- title
    local tf = CreateFrame("Button", nil, frame)
    tf:SetPoint("TOP",  0, -18)
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