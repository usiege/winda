-- zhCN localization
local _, wd = ...
local _, _, L = unpack(wd)

if GetLocale() ~= "zhCN" then return end

local wdGetThemeResRootPath = wdGetThemeResRootPath

L["Winda Console"] = "winda"

-- prompt
L["WELCOME"] = "Welcome to winda ui, please enjoy it."

-- textures
L["THEME_NAME"]         = "base"
L["RES_ROOT_PATH"]      = wdGetThemeResRootPath(L["THEME_NAME"])
L["FONT_CHINESE"]       = L["RES_ROOT_PATH"].."/fonts/chinese-font.ttf"
L["GUI_BACK_IMAGE"]     = L["RES_ROOT_PATH"].."/textures/UI-Tooltip-Background"
L["GUI_BG_FILE"]        = L["RES_ROOT_PATH"].."/textures/UI-Gui-BgFile"
L["GUI_BG_ITEM"]        = L["RES_ROOT_PATH"].."/textures/Gui-item-bg"
L["GUI_EDGE_FILE"]      = L["RES_ROOT_PATH"].."/textures/UI-Gui-EdgeFile"
L["WINDA_LOGO"]         = L["RES_ROOT_PATH"].."/textures/winda"
