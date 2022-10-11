if DEBUG then
    print("_Settings")
end
local _, wd = ...
local Winda, Deploy , L = unpack(wd)


local function modules()
    -- body

end


local function settings()
    -- body

end

local function loadPanel(name)
    -- body
    if DEBUG then print(name) end
    
    if name == "Modules" then
        do
            modules()
        end
    end

    if name == "Settings" then
        do
            settings()
        end
    end

end

------------

-- frame for all modules
-- a panel that can modify the open state of the module 
function Deploy:LoadStatesPanel(ParentFrame)
    loadPanel("Modules")
    return self
end


-- frame on move mode
-- a panel for moving aomponents
function Deploy:LoadSettingsPanel(ParentFrame)
    loadPanel("Settings")
    return self
end