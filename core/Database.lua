local _, wd = ...
local C, D, L, DB = unpack(wd)

local bit_band, bit_bor = bit.band, bit.bor
local COMBATLOG_OBJECT_AFFILIATION_MINE = COMBATLOG_OBJECT_AFFILIATION_MINE or 0x00000001

DB.Version = GetAddOnMetadata("NDui", "Version")
DB.Support = GetAddOnMetadata("NDui", "X-Support")
DB.Client = GetLocale()
DB.ScreenWidth, DB.ScreenHeight = GetPhysicalScreenSize()
DB.isClassic = select(4, GetBuildInfo()) < 90000
DB.isNewPatch = select(4, GetBuildInfo()) >= 30400 -- 3.4.0 WLK

-- Colors
DB.MyName = UnitName("player")
DB.MyRealm = GetRealmName()
DB.MyFullName = DB.MyName.."-"..DB.MyRealm
DB.MyClass = select(2, UnitClass("player"))
DB.MyFaction = UnitFactionGroup("player")
DB.ClassList = {}
for k, v in pairs(LOCALIZED_CLASS_NAMES_MALE) do
	DB.ClassList[v] = k
end
DB.ClassColors = {}
local colors = CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS
for class, value in pairs(colors) do
	DB.ClassColors[class] = {}
	DB.ClassColors[class].r = value.r
	DB.ClassColors[class].g = value.g
	DB.ClassColors[class].b = value.b
	DB.ClassColors[class].colorStr = value.colorStr
end
DB.r, DB.g, DB.b = DB.ClassColors[DB.MyClass].r, DB.ClassColors[DB.MyClass].g, DB.ClassColors[DB.MyClass].b
DB.MyColor = format("|cff%02x%02x%02x", DB.r*255, DB.g*255, DB.b*255)
DB.InfoColor = "|cff99ccff" --.6,.8,1
DB.GreyColor = "|cff7b8489"
DB.QualityColors = {}
local qualityColors = BAG_ITEM_QUALITY_COLORS
for index, value in pairs(qualityColors) do
	DB.QualityColors[index] = {r = value.r, g = value.g, b = value.b}
end
DB.QualityColors[-1] = {r = 0, g = 0, b = 0}
DB.QualityColors[LE_ITEM_QUALITY_POOR] = {r = .61, g = .61, b = .61}
DB.QualityColors[LE_ITEM_QUALITY_COMMON] = {r = 0, g = 0, b = 0}

-- Fonts
DB.Font = {STANDARD_TEXT_FONT, 12, "OUTLINE"}
DB.LineString = DB.GreyColor.."---------------"
DB.NDuiString = "|cff0080ffNDui:|r"

-- Textures
local Media = "Interface\\Addons\\NDui\\Media\\"
DB.bdTex = "Interface\\ChatFrame\\ChatFrameBackground"
DB.glowTex = Media.."glowTex"
DB.normTex = Media.."normTex"
DB.gradTex = Media.."gradTex"
DB.flatTex = Media.."flatTex"
DB.bgTex = Media.."bgTex"
DB.arrowTex = Media.."TargetArrow"
DB.starTex = Media.."Hutu\\star"
DB.MicroTex = Media.."Hutu\\Menu\\"
DB.rolesTex = Media.."Hutu\\RoleIcons"
DB.tankTex = Media.."Hutu\\Tank"
DB.healTex = Media.."Hutu\\Healer"
DB.dpsTex = Media.."Hutu\\DPS"
DB.chatLogo = Media.."Hutu\\logoSmall"
DB.logoTex = Media.."Hutu\\logoClassic"
DB.sortTex = Media.."SortIcon"
DB.closeTex = Media.."Hutu\\close"
DB.ArrowUp = Media.."Hutu\\arrow"
DB.afdianTex = Media.."Hutu\\Afdian"
DB.patreonTex = Media.."Hutu\\Patreon"
DB.mailTex = "Interface\\Minimap\\Tracking\\Mailbox"
DB.gearTex = "Interface\\WorldMap\\Gear_64"
DB.eyeTex = "Interface\\Minimap\\Raid_Icon"		-- blue: \\Dungeon_Icon
DB.garrTex = "Interface\\HelpFrame\\HelpIcon-ReportLag"
DB.copyTex = "Interface\\Buttons\\UI-GuildButton-PublicNote-Up"
DB.binTex = "Interface\\HelpFrame\\ReportLagIcon-Loot"
DB.questTex = "adventureguide-microbutton-alert"
DB.objectTex = "Warfronts-BaseMapIcons-Horde-Barracks-Minimap"
DB.creditTex = "Interface\\HelpFrame\\HelpIcon-KnowledgeBase"
DB.newItemFlash = "Interface\\Cooldown\\star4"
DB.sparkTex = "Interface\\CastingBar\\UI-CastingBar-Spark"
DB.TexCoord = {.08, .92, .08, .92}
DB.textures = {
	normal		= Media.."ActionBar\\gloss",
	flash		= Media.."ActionBar\\flash",
	pushed		= Media.."ActionBar\\pushed",
}
DB.LeftButton = " |TInterface\\TUTORIALFRAME\\UI-TUTORIAL-FRAME:13:11:0:-1:512:512:12:66:230:307|t "
DB.RightButton = " |TInterface\\TUTORIALFRAME\\UI-TUTORIAL-FRAME:13:11:0:-1:512:512:12:66:333:411|t "
DB.ScrollButton = " |TInterface\\TUTORIALFRAME\\UI-TUTORIAL-FRAME:13:11:0:-1:512:512:12:66:127:204|t "
DB.AFKTex = "|T"..FRIENDS_TEXTURE_AFK..":14:14:0:0:16:16:1:15:1:15|t"
DB.DNDTex = "|T"..FRIENDS_TEXTURE_DND..":14:14:0:0:16:16:1:15:1:15|t"

-- Flags
function DB:IsMyPet(flags)
	return bit_band(flags, COMBATLOG_OBJECT_AFFILIATION_MINE) > 0
end
DB.PartyPetFlags = bit_bor(COMBATLOG_OBJECT_AFFILIATION_PARTY, COMBATLOG_OBJECT_REACTION_FRIENDLY, COMBATLOG_OBJECT_CONTROL_PLAYER, COMBATLOG_OBJECT_TYPE_PET)
DB.RaidPetFlags = bit_bor(COMBATLOG_OBJECT_AFFILIATION_RAID, COMBATLOG_OBJECT_REACTION_FRIENDLY, COMBATLOG_OBJECT_CONTROL_PLAYER, COMBATLOG_OBJECT_TYPE_PET)

--[[ RoleUpdater
local function CheckRole()
	local tree = GetSpecialization()
	if not tree then return end
	local _, _, _, _, role, stat = GetSpecializationInfo(tree)
	if role == "TANK" then
		DB.Role = "Tank"
	elseif role == "HEALER" then
		DB.Role = "Healer"
	elseif role == "DAMAGER" then
		if stat == 4 then	--1?????????2?????????4??????
			DB.Role = "Caster"
		else
			DB.Role = "Melee"
		end
	end
end
B:RegisterEvent("PLAYER_LOGIN", CheckRole)
B:RegisterEvent("CHARACTER_POINTS_CHANGED", CheckRole)]]

-- Raidbuff Checklist
DB.BuffList = {
	[1] = {		-- ??????
		17627,	-- ????????????
		28518,	-- ????????????
		28519,	-- ??????????????????
		28520,	-- ??????????????????
		28521,	-- ??????????????????
		28540,	-- ??????????????????
		42735,	-- ????????????
		-- ????????????
		33726,	-- ????????????
		11406,	-- ????????????
		38954,	-- ??????????????????
		33721,	-- ????????????
		17539,	-- ??????????????????
		28491,	-- ????????????
		-- ????????????
		28502,	-- ????????????
		39625,	-- ??????????????????
		39626,	-- ????????????
		28514,	-- ??????
		28509,	-- ??????????????????
		39627,	-- ?????????????????????
	},
	[2] = {     -- ????????????
		104273, -- 250?????????BUFF?????????
	},
	[3] = {     -- 10%??????
		1459,
		264760,
	},
	[4] = {     -- 10%??????
		21562,
		264764,
	},
	[5] = {     -- 10%??????
		6673,
		264761,
	},
	[6] = {     -- ??????
		270058,
	},
}

-- Reminder Buffs Checklist
DB.ReminderBuffs = {
	MAGE = {
		{	spells = {	-- ????????????
				[1459] = true,
				[8096] = true,  -- ????????????
				[23028] = true, -- ????????????
				[46302] = true, -- ?????????????????????
			},
			depend = 1459,
			combat = true,
			instance = true,
			pvp = true,
		},
		{	spells = {
				[168] = true,	-- ?????????
				[7302] = true,	-- ?????????
				[6117] = true,	-- ????????????
				[30482] = true,	-- ????????????
			},
			depend = 168,
			combat = true,
			instance = true,
			pvp = true,
		},
	},
	PRIEST = {
		{	spells = {	-- ????????????
				[1243] = true,
				[8099] = true,  -- ????????????
				[21562] = true, -- ????????????
			},
			depend = 1243,
			combat = true,
			instance = true,
			pvp = true,
		},
		{	spells = {	-- ????????????
				[588] = true,
			},
			depend = 588,
			pvp = true,
		},
	},
	DRUID = {
		{	spells = {	-- ????????????
				[1126] = true,
				[21849] = true, -- ????????????
			},
			depend = 1126,
			combat = true,
			instance = true,
			pvp = true,
		},
		{	spells = {	--- ?????????
				[467] = true,
			},
			depend = 467,
			pvp = true,
		},
	},
	WARRIOR = {
		{	spells = {	-- ????????????
				[6673] = true,
			},
			depends = {6673, 5242, 6192, 11549, 11550, 11551, 25289, 2048},
			gemini = {
				[GetSpellInfo(469)] = true, -- ????????????
			},
			combat = true,
			instance = true,
			pvp = true,
		},
		{	spells = {	-- ????????????
				[469] = true,
			},
			depend = 469,
			gemini = {
				[GetSpellInfo(6673)] = true, -- ????????????
			},
			combat = true,
			instance = true,
			pvp = true,
		},
	},
	HUNTER = {
		{	spells = {	-- ????????????
				[13165] = true,
				[61846] = true, -- ??????
			},
			depend = 13165,
			combat = true,
			instance = true,
			pvp = true,
		},
		{	spells = {	--- ????????????
				[19506] = true,
			},
			depend = 19506,
			combat = true,
			instance = true,
			pvp = true,
		},
	},
	WARLOCK = {
		{	spells = {
				[28176] = true,	-- ?????????
				[706] = true,	-- ?????????
				[687] = true,	-- ????????????
			},
			depend = 28176,
			combat = true,
			instance = true,
			pvp = true,
		},
	},
	DEATHKNIGHT = {
		{	spells = {	-- ????????????
				[57330] = true,
			},
			depend = 57330,
			combat = true,
			instance = true,
			pvp = true,
		},
	},
}
