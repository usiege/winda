-- WDObject
local WDObject = Object:createSubclass("WDObject")

function WDObject:init(self, args) 
    for k,v in pairs(args) do
        self.k = v
    end

    return self
end


_G["WDObject"]  = WDObject
return WDObject