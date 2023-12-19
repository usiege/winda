local _, wd = ...
local Winda, Deploy , L = unpack(wd)

-- gui entity
-- gui base entity
GuiEntity = {
    index = 0, -- gui index

    index_frame     = nil,      -- gui button frame 
    setting_frame   = nil,      -- gui settings frame
    urlcopy_frame   = nil,

    index_text      = "",
}
setmetatable(GuiEntity, {__index = BaseEntity})


function GuiEntity: wdPrint()
    wdPrint(self.name)
    if self.entity ~= nil then
        wdPrint("entity name is: "..self.entity.name)
    end
end

function GuiEntity: new(o, name)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    o.name = name
    return o    
end

-- init cocreate frame
function GuiEntity: createGuiCocreate(parent)
    local frame = CreateFrame("Frame", "GUILogo", parent)
    frame:SetFrameLevel(WDC.GUI.window_level+2)
    local width, height = WDC.GUI.cocreate.logo_width, 
                          WDC.GUI.cocreate.logo_height
    local x, y = WDC.GUI.cocreate.logo_point[1], 
                 WDC.GUI.cocreate.logo_point[2]
    wdPrint(width, height)
    frame:SetPoint("TOP", parent, "TOP", 0, -y)
    frame:SetSize(width, height)
    frame:SetFrameStrata("HIGH")
    -- -- adding a texture
    local texture = frame:CreateTexture(nil, "BACKGROUND")
    texture:SetTexture(L["WINDA_LOGO_LARGE"])
    texture:SetAllPoints()

    -- -- mouse event
    -- frame:SetMouseClickEnabled(true)
    -- frame:SetScript("OnEnter", function(self, motion) 
    --     wdPrint("OnEnter", motion) 
    -- end)
    -- frame:SetScript("OnLeave", function(self, motion) 
    --     wdPrint("OnLeave", motion) 
    -- end)
    -- frame:SetScript("OnMouseDown", function(self, button) 
    --     wdPrint("OnMouseDown", button) 
    -- end)
    -- frame:SetScript("OnMouseUp", function(self, button) 
    --     wdPrint("OnMouseUp", button) 
    -- end)

    return frame
end




-- init gui item buttons
function GuiEntity:createGuiItem(index, parent)
    local frame = CreateFrame("Button", nil, parent)
    frame:SetPoint("TOPLEFT",  
    WDC.GUI.entity.index_referto_point[1], 
    WDC.GUI.entity.index_referto_point[2] - (WDC.GUI.entity.index_button_height + WDC.GUI.entity.index_padding_height) * (index - 1))
    frame:SetSize(WDC.GUI.entity.index_button_width, 
                  WDC.GUI.entity.index_button_height)
    frame:SetFrameStrata("HIGH")

    -- button text
    local fs = frame:CreateFontString(nil, 'OVERLAY')
	fs:SetFont(L["FONT_LANTY"], 12, "OUTLINE")
	fs:SetPoint('CENTER')
	fs:SetText(self.index_text)
	fs:SetJustifyH('CENTER')
	fs:SetTextColor(1, 1, 1, 1)
	frame:SetFontString(fs)

    -- bg image
    wdPrint(self.index_text)
    local texture = frame: CreateTexture(nil, "BACKGROUND")
    texture:SetTexture(L["GUI_BUTTON_BG"])
    texture:SetAllPoints()
    -- wdPrint(self.index_referto_point)

    self.index = index
    self.index_frame = frame
end

-- init url copy frame
function GuiEntity:createURLCopy(arg)
    local urlcopy = CreateFrame("Frame", "GUIURLCopyWD", UIParent, "BackdropTemplate")
    urlcopy:Hide()
    -- urlcopy:SetWidth(WDC.GUI.url_copy.bg_width)
    -- urlcopy:SetHeight(WDC.GUI.url_copy.bg_height)
    wdPrint(urlcopy)
    urlcopy:SetSize(WDC.GUI.url_copy.bg_width, WDC.GUI.url_copy.bg_height)
    urlcopy:SetFrameLevel(100)
    urlcopy:SetPoint("CENTER", 0, 0)
    urlcopy:SetFrameStrata("HIGH")

    local pad = 5
    urlcopy:SetBackdrop({
        bgFile = L["BG_BLACK_NORMAL"], --L["BG_FILE_NORMAL"],
        edgeFile = L["EDGE_NORMAL"],
        tile = false,
        tileEdge = false,
        tileSize = 0,
        edgeSize = pad,
        insets = { left = pad, right = pad, top = pad, bottom = pad }
    })
    urlcopy:SetBackdropBorderColor(0, 0, 0, 1)
    
    urlcopy:SetMovable(true)
    urlcopy:EnableMouse(true)
    urlcopy:RegisterForDrag("LeftButton")
    urlcopy:SetScript("OnDragStart",function(self)
        self:StartMoving()
    end)

    urlcopy:SetScript("OnDragStop",function(self)
        self:StopMovingOrSizing()
    end)

    urlcopy:SetScript("OnShow", function(self)
        self.text:HighlightText()
    end)


    urlcopy.text = CreateFrame("EditBox", "URLCopyEditBoxWD", urlcopy)
    urlcopy.text:SetTextColor(.2,1,.8,1)
    urlcopy.text:SetJustifyH("CENTER")
    urlcopy.text:SetWidth(WDC.GUI.url_copy.text_width)
    urlcopy.text:SetHeight(WDC.GUI.url_copy.text_height)
    urlcopy.text:SetPoint("TOP", urlcopy, "TOP", 
                         WDC.GUI.url_copy.text_point[1], WDC.GUI.url_copy.text_point[2])
    urlcopy.text:SetFontObject(GameFontNormal)

    urlcopy.text:SetScript("OnEscapePressed", function(self)
        urlcopy:Hide()
    end)
    urlcopy.text:SetScript("OnEditFocusLost", function(self)
        urlcopy:Hide()
    end)

    urlcopy.close = CreateFrame("Button", "GUIURLCopyCloseWD", urlcopy, "UIPanelButtonTemplate")
    urlcopy.close:SetWidth(WDC.GUI.url_copy.close_width)
    urlcopy.close:SetHeight(WDC.GUI.url_copy.close_height)
    urlcopy.close:SetPoint("BOTTOMRIGHT", urlcopy, "BOTTOMRIGHT", 
                            WDC.GUI.url_copy.close_point[1], WDC.GUI.url_copy.close_point[2])
    urlcopy.close:SetText(L["CLOSE"])

    urlcopy.close:SetScript("OnClick", function()
        urlcopy:Hide()
    end)

    urlcopy.CopyText = function(text)
        urlcopy:Hide()
        urlcopy.text:SetText(text)
        urlcopy:Show()
    end

    
    -- function _G.SetItemRef(link, text, button)
    --     if (strsub(link, 1, 3) == "url") then
    --       if string.len(link) > 4 and string.sub(link,1,4) == "url:" then
    --         urlcopy.CopyText(string.sub(link,5, string.len(link)))
    --       end
    --       return
    --     end
    --     urlcopy.SetItemRef(link, text, button)
    -- end
    -- urlcopy.SetItemRef = SetItemRef
    
    self.urlcopy_frame = urlcopy
end



-- init item setting frame 
function GuiEntity:createGuiItemDetail(index, parent)
    -- setting
    local frame = CreateFrame("Frame", "", parent, "BackdropTemplate")
    local x,y = -WDC.GUI.entity.setting_topright_point[1], 
                -WDC.GUI.entity.setting_topright_point[2]
    frame:SetPoint("TOP", parent, "TOP", x, y)
    frame:SetSize(WDC.GUI.entity.setting_item_width, 
                  WDC.GUI.entity.setting_item_height)
    frame:SetFrameStrata("HIGH")
    frame:SetBackdrop({
        bgFile = "",
        -- bgFile = L["GUI.SETTING_BG_GREEN"], --L["GUI.BG_ITEM"]
    })
    frame:Hide()

    -- winda cocreate add sub compenents
    if self.index_text == L["MODULE_COCREATE"] then
        self:createGuiCocreate(frame)
        local paths = {
            L["GUI_COCREATE_REQUIRE"],
            L["GUI_COCREATE_DESIGN"],
            L["GUI_COCREATE_SCHEME"],
            L["GUI_COCREATE_CODE"],
            L["GUI_COCREATE_BUG"]
        }
        local urls = {
            L["URL_COCREATE_REQUIRE"],
            L["URL_COCREATE_DESIGN"],
            L["URL_COCREATE_SCHEME"],
            L["URL_COCREATE_CODE"],
            L["URL_COCREATE_BUG"]
        }

        -- create exitbox
        self:createURLCopy()
        local this = self
        -- self.urlcopy_frame = urlcopy

        -- setup cocreate buttons 
        for index, value in ipairs(paths) do
            -- setup cocreate buttons
            local button = CreateFrame("Button", nil, frame)
            local eachY = -(WDC.GUI.cocreate.button_referto_point[2]+
                        (WDC.GUI.cocreate.button_height+WDC.GUI.cocreate.button_padding_y)*(index-1))
            button:SetPoint("TOP", 0, eachY)
            button:SetWidth(WDC.GUI.cocreate.button_width)
            button:SetHeight(WDC.GUI.cocreate.button_height)
            local texture = button:CreateTexture(nil, "BACKGROUND")
            texture:SetTexture(value)
            texture:SetAllPoints()
            button:SetScript("OnClick", function (self, button, down) 
                wdPrint(value)
                wdPrint(this.urlcopy_frame)
                if this.urlcopy_frame then 
                    wdPrint(urls[index])
                    this.urlcopy_frame.CopyText(urls[index])
                end
            end)
            
        end
    end


    -- -- title
    -- local tf = CreateFrame("Button", nil, frame)
    -- tf:SetPoint("TOP",  0, -12)
    -- tf:SetSize(200, 64)
    -- tf:SetFrameStrata("HIGH")
    -- local fs = tf:CreateFontString(nil, 'OVERLAY')
	-- fs:SetFont(L["FONT_LANTY"], 24, "OUTLINE")
	-- fs:SetPoint('CENTER')
	-- fs:SetText(self.index_text)
	-- fs:SetJustifyH('CENTER')
	-- fs:SetTextColor(1, 1, 1, 1)
	-- tf:SetFontString(fs)
    -- frame.title = tf -- outside useful

    -- store
    self.setting_frame = frame
end

-- create exit box for cocreate button
function GuiEntity:createExitBox(parent)
    
end
