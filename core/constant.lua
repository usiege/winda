-- contant settings
local Constants = {
    name = "constant";
    -- gui
    gui_window_width = 800,
    gui_window_height = 600,
    gui_window_level = 10,

    --
}

wdConstants = Constants
if DEBUG then
    print(wdConstants.name)
end
return wdConstants
