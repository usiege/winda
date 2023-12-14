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


function BaseEntity:createText(parent)
    
end