-- addon init
local addonName, wd = ... -- addon name and winda table
print("welcome to "..addonName.."!")

local tinsert, next = table.insert, next


-- prepare
local Winda = {}    -- winda handle
local Deploy = {}   -- configs for winda
local L = {}        -- Locales
local DB = {}       -- Databases


------------------------------------------------------------------------
-- Core winda
-- Entities private value for entities info
-- these entities are module entity (just like Bags, Bars, etc.)
-- module has own entity which is frame 
local entities, entityQueue = {}, {}
function Winda:RegisterEntity(name)
	if entities[name] then print("Module <"..name.."> has been registered.") return end
	local module = {}
	module.name = name
	entities[name] = module

	tinsert(entityQueue, module)
	return module
end
function Winda:GetEntity(name)
	if not entities[name] then print("Module <"..name.."> does not exist.") return end

	return entities[name]
end

-- winda event register 
local events = {} -- event trace
function Winda:LoginEvent (args) -- player login
	-- body...
	print("player login...")
    --
    for _, entity in next, entityQueue do
        if entity.OnLogin then
            entity:OnLogin()
        else
            print("Module <"..module.name.."> does not loaded.")
        end
    end
end

------------------------------------------------------------------------
-- Deploy
Winda.VERSION_STRING = "@project-version@ Classic"

------------------------------------------------------------------------
-- DB


------------------------------------------------------------------------
-- frame handle
do
	local handle = CreateFrame("Frame")
	handle:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	handle:RegisterEvent("PLAYER_LOGIN", Winda.LoginEvent)
	handle:SetScript("OnEvent", function(_, event, ...)
		-- print(CombatLogGetCurrentEventInfo())
		if event == "PLAYER_LOGIN" then
			Winda:LoginEvent()
		end
	end)
	-- setup frame handle
	Winda.entity = handle
end


------------------------------------------------------------------------
-- wd settings
wd[1] = Winda
wd[2] = Deploy
wd[3] = L
wd[4] = DB
-- global wd
_G[addonName] = wd
