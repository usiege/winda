if DEBUG then
    print("action bar")
end

local _, wd = ...
local Winda, Deploy , L, DB = unpack(wd)

local UIParent = UIParent
local CreateFrame = CreateFrame



-- load
local ActionBar     = Winda:Regist8erEntity("ActionBar")
local WDActionBar   = WindaEntity:new({})

-- build module and entity relationship with winda property
ActionBar.winda = WDActionBar

-- hidden parent entity
local hiddenParent = CreateFrame('Frame', nil, UIParent)
hiddenParent:SetAllPoints()
hiddenParent:Hide()
WDActionBar.entity = hiddenParent

function WDActionBar: disableBlizzard() 
    
end

do
    
   
end


WDActionBar = WDActionBar