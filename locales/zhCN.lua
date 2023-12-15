-- zhCN localization
local _, wd = ...
local _, _, L = unpack(wd)

if GetLocale() ~= "zhCN" then return end

local wdGetThemeResRootPath = wdGetThemeResRootPath


-- prompt
L["Winda Console"] = "winda 控制台"

L["WELCOME"]            = "Welcome to winda ui, please enjoy it."
L["CLOSE"]				= "关闭"
L["MODULE_ENABLE_DESC"] = "开启或关闭模块功能"


-- module
L["MODULE_ABOUT"]       = "关于"
L["MODULE_COCREATE"]    = "|cFFFFCC22温达共创|r"
L["MODULE_ENABLE"]      = "模块开关"
L["MODULE_BAGS"]        = "背包"
L["MODULE_BARS"]        = "动作条"
L["MODULE_BUFF"]        = "增/减益"
L["MODULE_CHAT"]        = "聊天框"
L["MODULE_COMBAT"]      = "战斗"
L["MODULE_MAPS"]        = "地图"
L["MODULE_NAMEPLATE"]   = "姓名版"
L["MODULE_TASK"]        = "任务"
L["MODULE_TOOLTIP"]     = "提示"
L["MODULE_UNITFRAME"]   = "头像"

L["MODULE_SKIN"]        = "皮肤"
L["MODULE_DEPLOY"]      = "配置"

L["MODULE_EXTEND"]      = "扩展"
L["MODULE_SEARCH_NORMAL"]       = "[搜索]"
L["MODULE_SEARCH_ING"]          = "|c0000FFFF[搜索]|r"
L["MODULE_SEARCH_DOWN"]         = "|c00FFFF77[搜索]|r"

-- system
L["MODULE_ROLE"]        = "角色"    -- 声望，PvP，头衔，技能
L["MODULE_EQUIP"]       = "装备"    -- 一键换装，自动切换
L["MODULE_SPELL"]       = "法术"
L["MODULE_TALENT"]      = "天赋"
L["MODULE_GLYPH"]       = "雕文"
L["MODULE_MOUNT"]       = "座骑"
L["MODULE_PET"]         = "宠物"
L["MODULE_COIN"]        = "货币"


--------

L["URL_COCREATE_REQUIRE"]	= "飞书链接：https://kxxblqyumrm.feishu.cn/sheets/BeMjsw2JRhaLVIty2sCcwuVWnJf 密码：6Z75#899"
L["URL_COCREATE_DESIGN"]	= "https://www.figma.com/file/mDJJYea7WDsNhEVgAmkYk5/%E6%B8%A9%E8%BE%BE%E5%85%B1%E5%88%9B?type=design&node-id=0%3A1&mode=design&t=oEQqV3BnnAmFvNkq-1"
L["URL_COCREATE_SCHEME"]	= "飞书链接：https://kxxblqyumrm.feishu.cn/docx/VWOTd6GaooSa1vxNyFpcpnw6nbg   密码：1k65956#"	
L["URL_COCREATE_CODE"]		= "https://github.com/usiege/winda"
L["URL_COCREATE_BUG"]		= "飞书链接：https://kxxblqyumrm.feishu.cn/sheets/I9NLsCaGVhHUL4tl6OBcCA61nJg 密码：d9732@31"	


------------------------------ THEME PATH -------------------------
-- base (user custom setting)
L["THEME_NAME"]         = "base"
L["RES_ROOT_PATH"]      = wdGetThemeResRootPath(L["THEME_NAME"])

-- fonts 
L["FONT_LANTY"]         = L["RES_ROOT_PATH"].."/fonts/lanty.ttf"
L["FONT_CHINESE"]       = L["RES_ROOT_PATH"].."/fonts/chinese-font.ttf"


-- textures
L["EDGE_NORMAL"]        = "Interface/Tooltips/UI-Tooltip-Border"

L["CANCEL_CLEAR"]       = L["RES_ROOT_PATH"].."/textures/cancel-clear"
L["CANCEL_NORMAL"]      = L["RES_ROOT_PATH"].."/textures/cancel-normal"

L["BG_FILE_NORMAL"]     = L["RES_ROOT_PATH"].."/textures/bg-black-normal"
L["BG_GRAY_SQUARE"]     = L["RES_ROOT_PATH"].."/textures/bg-gray-square"

L["GUI_BACK_IMAGE"]     = L["RES_ROOT_PATH"].."/textures/UI-Tooltip-Background"
L["GUI_BG_FILE"]        = L["RES_ROOT_PATH"].."/textures/UI-Gui-BgFile"
L["GUI_EDGE_FILE"]      = L["RES_ROOT_PATH"].."/textures/UI-Gui-EdgeFile"

L["GUI_BG_ITEM"]        = L["RES_ROOT_PATH"].."/textures/gui-item-bg"
L["GUI_BUTTON_BG"]      = L["RES_ROOT_PATH"].."/textures/gui-button-bg"

L["GUI_SETTING_BG_GREEN"]     = L["RES_ROOT_PATH"].."/textures/gui-setting-bg-green"
L["GUI_SETTING_BG_BLACK"]     = L["RES_ROOT_PATH"].."/textures/gui-setting-bg-black"

L["WINDA_LOGO"]         = L["RES_ROOT_PATH"].."/textures/winda"
L["WINDA_LOGO_LARGE"]   = L["RES_ROOT_PATH"].."/textures/winda-large"
L["WINDA_LOGO_SMALL"]   = L["RES_ROOT_PATH"].."/textures/winda-small"

L["GUI_BUTTON_ARROW"]       = L["RES_ROOT_PATH"].."/textures/arrow.png"
L["GUI_COCREATE_REQUIRE"]   = L["RES_ROOT_PATH"].."/textures/cocreate_require.png"
L["GUI_COCREATE_DESIGN"]    = L["RES_ROOT_PATH"].."/textures/cocreate_design.png"
L["GUI_COCREATE_SCHEME"]    = L["RES_ROOT_PATH"].."/textures/cocreate_scheme.png"
L["GUI_COCREATE_CODE"]      = L["RES_ROOT_PATH"].."/textures/cocreate_code.png"
L["GUI_COCREATE_BUG"]       = L["RES_ROOT_PATH"].."/textures/cocreate_bug.png"

-- TODO: path suffix dispose

-- icons
L["GUI_MINIMAP_ICON"]        = L["RES_ROOT_PATH"].."/icons/logo_minimap.png"
L["MODULE_BAGS_ICON"]        = L["RES_ROOT_PATH"].."/icons/Module-bag"
L["MODULE_BARS_ICON"]        = L["RES_ROOT_PATH"].."/icons/Module-bar"
L["MODULE_BUFF_ICON"]        = L["RES_ROOT_PATH"].."/icons/Module-buff"
L["MODULE_CHAT_ICON"]        = L["RES_ROOT_PATH"].."/icons/Module-chat"
L["MODULE_COMBAT_ICON"]      = L["RES_ROOT_PATH"].."/icons/Module-combat"
L["MODULE_MAPS_ICON"]        = L["RES_ROOT_PATH"].."/icons/Module-map"
L["MODULE_NAMEPLATE_ICON"]   = L["RES_ROOT_PATH"].."/icons/Module-nameplate"
L["MODULE_TASK_ICON"]        = L["RES_ROOT_PATH"].."/icons/Module-task"
L["MODULE_TOOLTIP_ICON"]     = L["RES_ROOT_PATH"].."/icons/Module-tooltip"
L["MODULE_UNITFRAME_ICON"]   = L["RES_ROOT_PATH"].."/icons/Module-unitframe"
L["MODULE_SKIN_ICON"]        = L["RES_ROOT_PATH"].."/icons/Module-skin"
L["MODULE_DEPLOY_ICON"]      = L["RES_ROOT_PATH"].."/icons/Module-deploy"
L["MODULE_DXTEND_ICON"]      = L["RES_ROOT_PATH"].."/icons/Module-extend"