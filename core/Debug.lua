-- global debug
DEBUG = true
wdebug = {}

-- debug testing
if DEBUG then
    print("debug is open...")
end

-- function 
function wdPrint(...)
    if DEBUG then
        print(...)
    end
    do end
end


-- functions 
wdPrint = wdPrint

-- package debug
return wdebug
