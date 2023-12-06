-- global debug
DEBUG = true
wdebug = {}

-- function 
function wdPrint(...)
    if DEBUG then
        print(...)
    end
        -- do nothing ...
    do end
end

-- debug testing
if DEBUG then
    wdPrint("debug is open...")
end

-- functions 
wdPrint = wdPrint

-- package debug
return wdebug
