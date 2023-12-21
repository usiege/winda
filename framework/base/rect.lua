-- _G[""] = Object:new({

-- })

-- CONSTANT
_G["WDAnchor"] = {
    TL = "TOPLEFT",     T = "TOP",      TR = "TOPRIGHT",
    L  = "LEFT",        C = "CENTER",   R  = "RIGHT",
    BL = "BOTTOMLEFT",  B = "BOTTOM",   BR = "BOTTOMRIGHT"    
}

_G["WDFrameLevel"] = {
    BACKGROUND  = "BACKGROUND",
    LOW         = "LOW",
    MEDIUM      = "MEDIUM",
    HIGH        = "HIGH",
    DIALOG      = "DIALOG",
    FULLSCREEN  = "FULLSCREEN",
    TOOLTIP     = "TOOLTIP"
} 


-- STRUCT
_G["WDSize"] = Object:new({
    width = 0,
    height = 0,
})

_G["WDPoint"] = Object:new({
    x = 0,
    y = 0,
})

_G["WDRect"] = Object:new({
    x = 0, y = 0, 
    width = 0, height = 0
})

_G["WDPosition"] = Object:new({
    parent = nil,
    anchor = WDAnchor.C,            -- 
    relativeAnchor = WDAnchor.C,
    x = 0, y = 0, 
    width = 0, height = 0
})

