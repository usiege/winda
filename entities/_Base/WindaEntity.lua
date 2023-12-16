-- winda base frame
-- create winda entity frame 
local BaseEntity = BaseEntity

WindaEntity = {
    name = "WindaFrame",
    entity = nil,

}
setmetatable(WindaEntity, {__index = BaseEntity})
WindaEntity.__index = WindaEntity


function WindaEntity: new(o, name)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    o.name = name
    return o    
end

function WindaEntity: wdPrint()
    wdPrint(self.name)
end

function WindaEntity: createButton(args)
    
end
