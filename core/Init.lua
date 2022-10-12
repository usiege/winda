local _, wd = ...
local Winda, Deploy , L = unpack(wd)

-- function 
function wdPrint(...)
    if DEBUG then
        print(...)
    end
end

wdPrint = wdPrint