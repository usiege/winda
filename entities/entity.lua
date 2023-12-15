-- module base entity 
-- entity is winda global module 
-- module's entity is frame which create by Blizz API
BaseEntity = {
    name = "BaseEntity",
    entity = nil,   -- a frame create by blizz api
    parent = nil,   -- entity parent must existed
}
setmetatable(BaseEntity, {__index = BaseEntity})
BaseEntity.__index = BaseEntity


-- BaseEntity: createButton
function BaseEntity:createImage(parent, size, position, imgPath, frameStrata, name)
    local frame = CreateFrame("Button", (name==nil and name or ""))
    frame:SetParent(parent)
    frame:SetPoint(position[1], parent, position[3], position[4], position[5])
    -- frame:SetSize(size[1], size[2])
    frame:SetWidth(size[1])
    frame:SetHeight(size[2])
    frame:SetFrameStrata(frameStrata)

    -- bg image
    local texture = frame: CreateTexture(nil, "BACKGROUND")
    texture:SetTexture(imgPath)
    texture:SetAllPoints()

    return frame
end


function BaseEntity:createBackdrop(f, legacy, transp)
    local er, eg, eb, ea = .4,.4,.4,1
    local br, bg, bb, ba = 0,0,0,1
    -- exit if now frame was given
    if not f then return end
    if transp then ba = transp end

    -- use legacy backdrop handling
    if legacy then
        f:SetBackdrop(L["GUI_SETTING_BG_BLACK"])
        f:SetBackdropColor(br, bg, bb, ba)
        f:SetBackdropBorderColor(er, eg, eb , ea)
        return
    end

    -- todo 
end


function BaseEntity:createURLCopy(arg)
    local urlcopy = CreateFrame("Frame", "GUIURLCopyWD", UIParent, "BackdropTemplate")
    urlcopy:Hide()
    urlcopy:SetWidth(270)
    urlcopy:SetHeight(65)
    urlcopy:SetFrameStrata("FULLSCREEN")
    urlcopy:SetPoint("CENTER", 0, 0)
    local pad = 1
    urlcopy:SetBackdrop({
        bgFile = L["GUI_SETTING_BG_GREEN"],
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
    urlcopy.text:SetWidth(250)
    urlcopy.text:SetHeight(20)
    urlcopy.text:SetPoint("TOP", urlcopy, "TOP", 0, -10)
    urlcopy.text:SetFontObject(GameFontNormal)

    urlcopy.text:SetScript("OnEscapePressed", function(self)
        urlcopy:Hide()
    end)
    urlcopy.text:SetScript("OnEditFocusLost", function(self)
        urlcopy:Hide()
    end)

    urlcopy.close = CreateFrame("Button", "GUIURLCopyCloseWD", urlcopy, "UIPanelButtonTemplate")
    urlcopy.close:SetWidth(70)
    urlcopy.close:SetHeight(18)
    urlcopy.close:SetPoint("BOTTOMRIGHT", urlcopy, "BOTTOMRIGHT", -10, 10)

    urlcopy.close:SetText(L["CLOSE"])
    urlcopy.close:SetScript("OnClick", function()
        urlcopy:Hide()
    end)

    -- urlcopy.SetItemRef = SetItemRef
    urlcopy.CopyText = function(text)
        urlcopy.text:SetText(text)
        urlcopy:Show()
    end
    
    return urlcopy
end

-- function _G.SetItemRef(link, text, button)
--     if (strsub(link, 1, 3) == "url") then
--         if string.len(link) > 4 and string.sub(link,1,4) == "url:" then
--             urlcopy.CopyText(string.sub(link,5, string.len(link)))
--         end
--         return
--     end
--     urlcopy.SetItemRef(link, text, button)
-- end