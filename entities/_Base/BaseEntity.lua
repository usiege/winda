-- module base entity 
-- entity is winda global module 
-- module's entity is frame which create by Blizz API
BaseEntity = {
    name = "BaseEntity",
    entity = nil -- a frame create by blizz api
}
setmetatable(BaseEntity, {__index = BaseEntity})
BaseEntity.__index = BaseEntity

function BaseEntity: print()
    print(self.name)
    if self.entity ~= nil then
        print("entity name is: "..self.entity.name)
    end
end
