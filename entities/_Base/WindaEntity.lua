-- winda base frame
-- create winda entity frame 

WindaEntity = {
    name = "WindaFrame",
    entity = nil,

}
setmetatable(WindaEntity, {__index = WindaEntity})
WindaEntity.__index = WindaEntity


function WindaEntity: new(o, name)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    o.name = name
    return o    
end

function WindaEntity: print()
    print(self.name)
end

function WindaEntity: createButton(args)
    
end
