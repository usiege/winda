-- winda base frame
-- create winda entity frame 

WindaEntity = {
    name = "WindaFrame"
}
setmetatable(WindaEntity, {__index = WindaEntity})
WindaEntity.__index = WindaEntity

function WindaEntity: print()
    print(self.name)
end

function WindaEntity: createButton(args)
    
end
