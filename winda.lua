-- addon init
local addonName, wd = ... -- addon name and winda table
print("welcome to "..addonName.."!")


-- prepare
local Winda = {}    -- winda handle
local Deploy = {}   -- configs for winda
local L = {}        -- Locales
local DB = {}       -- Databases

-- local Core, Deploy, L, DB = unpack(wd)


-- Core winda


-- Deploy


-- DB



-- wd settings
wd[1] = Winda
wd[2] = Deploy
wd[3] = L
wd[4] = DB
-- global wd
_G[addonName] = wd
