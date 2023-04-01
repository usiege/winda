local _, wd = ...
local Winda, Deploy , L = unpack(wd)
local GuiEntity = GuiEntity


local function loadPanel(name)
    -- body
    if DEBUG then print(name) end
    

end



------------

function Deploy:LoadActionbarPanel(ParentFrame)
    loadPanel("ActionBar")
    return self
end