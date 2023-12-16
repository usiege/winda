print("|c0000FFFFWelcome to winda !|r")
-- addon init
local addonName, WD = ... -- addon name and winda table
-- wdPrint(...)
wdPrint("Welcome to "..addonName.." !")

local tinsert, next  = table.insert, next
local tonumber, tostring = tonumber, tostring
local GetAddOnMetadata = GetAddOnMetadata

-- prepare
local Winda = {}    -- winda handle
local Deploy = {}   -- configs for winda
local L = {}        -- Locales
local DB = {}       -- Databases
-- sub prepare
local version = {}


------------------------------------------------------------------------
-- Core winda
-- Entities private value for entities info
-- these entities are module entity (just like Bags, Bars, etc.)
-- module has own entity which is frame 
local entities, entityQueue = {}, {}
function Winda:RegisterEntity(name)
	if entities[name] then wdPrint("Module <"..name.."> has been registered.") return end
	local module = {}
	module.name = name
	entities[name] = module

	tinsert(entityQueue, module)
	return module
end
function Winda:GetEntity(name)
	if not entities[name] then wdPrint("Module <"..name.."> does not exist.") return end

	return entities[name]
end

-- winda event register 
local events = {} -- event trace
function Winda:LoginEvent (args) -- player login
	-- body...
    
	-- version
	local an = addonName
	local vstr = tostring(GetAddOnMetadata(an, "Version"))
	local major, minor, fix = wdStrsplit(".", vstr)
	version.major = tonumber(major)
	version.minor = tonumber(minor)
	version.fix = tonumber(fix)
	version.string = vstr
	WD.version = version

	-- entities
    for _, entity in next, entityQueue do
        if entity.OnLogin then
            entity:OnLogin()
        else
            wdPrint("Module <"..entity.name.."> does not loaded.")
        end
    end
end

------------------------------------------------------------------------
-- Deploy
Winda.VERSION_STRING = "@project-version@ Classic"

------------------------------------------------------------------------
-- DB
DB.addonName = addonName

------------------------------------------------------------------------
-- frame handle
do
	local handle = CreateFrame("Frame")
	handle:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	handle:RegisterEvent("PLAYER_LOGIN", Winda.LoginEvent)
	handle:SetScript("OnEvent", function(_, event, ...)
		-- wdPrint(CombatLogGetCurrentEventInfo())
		if event == "PLAYER_LOGIN" then
			Winda:LoginEvent()
		end
	end)
	-- setup frame handle
	Winda.entity = handle
end


------------------------------------------------------------------------
-- wd settings
WD[1] = Winda
WD[2] = Deploy
WD[3] = L
WD[4] = DB
-- global wd
_G[addonName] = WD
