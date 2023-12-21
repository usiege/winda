-- uiframe
local WDFrame = WDObject:createSubclass("WDFrame")
WDFrame:init({
    name                = "",
    frame               = nil,
    parent              = nil,
})

function WDFrame:initWithFrame(self, name, parent)
    self.name   = name
    self.parent = parent
    self.frame = CreateFrame("Frame", name, parent)


end

-- function WDFrame:SetRect(self, )