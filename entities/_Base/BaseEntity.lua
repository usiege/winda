local _, wd = ...
local Winda, Deploy , L = unpack(wd)

-- module base entity 
-- entity is winda global module 
-- module's entity is frame which create by Blizz API
BaseEntity = {
    name = "BaseEntity",
    entity = nil,  -- a frame create by blizz api
    
    index = 0, -- 
    index_frame = nil,  -- gui button frame 
    setting_frame = nil, -- gui settings frame

    index_text = "",
    index_referto_point     = {10, -88},
    index_padding_height    = 8,
    index_button_width      = 180,
    index_button_height     = 32,

}
setmetatable(BaseEntity, {__index = BaseEntity})
BaseEntity.__index = BaseEntity

function BaseEntity: print()
    print(self.name)
    if self.entity ~= nil then
        print("entity name is: "..self.entity.name)
    end
end

function BaseEntity: new(o, name)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    o.name = name
    return o    
end

function BaseEntity: createGuiIndex(index, parent)
    local frame = CreateFrame("Button", nil, parent)
    frame:SetPoint("TOPLEFT",  self.index_referto_point[1], 
    self.index_referto_point[2] - (self.index_button_height + self.index_padding_height) * (index - 1))
    frame:SetSize(self.index_button_width, self.index_button_height)
    frame:SetFrameStrata("HIGH")

    local fs = frame:CreateFontString(nil, 'OVERLAY')
	fs:FontTemplate()
	fs:SetPoint('CENTER')
	fs:SetText(self.index_text)
	fs:SetJustifyH('CENTER')
	fs:SetTextColor(1, 1, 1, 1)
	frame:SetFontString(fs)

    -- 
    wdPrint(self.index_text)
    local texture = frame: CreateTexture(nil, "BACKGROUND")
    texture:SetTexture(L["GUI_BUTTON_BG"])
    texture:SetAllPoints()
    -- print(self.index_referto_point)

    self.index_frame = frame
end

function BaseEntity: createGuiSettingItem(index)
    
end