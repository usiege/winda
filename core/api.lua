--[[
    lua global api
]]--
string = string
table = table
unpack = unpack
tostring = tostring


--[[
    winda personal api using lua
]]--
function wdStrsplit(delimiter, subject)
    if not subject then return nil end
    local delimiter, fields = delimiter or ":", {}
    local pattern = string.format("([^%s]+)", delimiter)
    string.gsub(subject, pattern, function(c) 
        fields[table.getn(fields)+1] = c 
    end)
    return unpack(fields)
end

