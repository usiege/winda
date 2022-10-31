-- module base entity 
-- entity is winda global module 
-- module's entity is frame which create by Blizz API
BaseEntity = {
    name = "BaseEntity",
    entity = nil,  -- a frame create by blizz api
    
    index = 0, -- 
    index_frame = nil,  -- gui button frame 
    setting_frame = nil, -- gui settings frame

    index_referto_point     = {0, 0},
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
    self.index_frame = CreateFrame("Button", nil, parent, "BackdropTemplate")
    

end

function BaseEntity: createGuiSettingItem(index)
    
end