-- zhCN localization
local _, wd = ...
local _, _, L = unpack(wd)

if GetLocale() ~= "zhCN" then return end

local wdGetThemeResRootPath = wdGetThemeResRootPath

L["Winda Console"] = "winda"

-- prompt
L["WELCOME"] = "Welcome to winda ui, please enjoy it."

-- theme
L["THEME_NAME"] = "base"
L["FONT_CHINESE"] = wdGetThemeResRootPath(L["THEME_NAME"]).."/fonts/chinese-font.ttf"
L["GUI_BACK_IMAGE"] = wdGetThemeResRootPath(L["THEME_NAME"]).."/textures/UI-Tooltip-Background"
