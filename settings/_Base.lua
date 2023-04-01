if DEBUG then
    print("_Base")
end

local _, wd = ...
local Winda, Deploy , L = unpack(wd)

-- settings panel entity frame
PanelEntity = {
    name = "PanelEntity",
    entity = nil,  -- a frame create by blizz api

}
setmetatable(PanelEntity, {__index = PanelEntity})
PanelEntity.__index = PanelEntity

