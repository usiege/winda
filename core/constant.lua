-- contant settings
local Constants = {
    name = "constant";
    -- gui
    gui_window_width    = 1000,
    gui_window_height   = 800,
    gui_window_level    = 10,
    gui_border_pad      = 5,
    gui_list_width      = 200,
    gui_list_height     = 800, 
    gui_item_width      = 180,
    gui_item_height     = 33,
    gui_item_padding    = 7,
    gui_logo_width      = 128,
    gui_logo_height     = 64,
    gui_logo_point      = {36, 18},
    --
}

wdConstants = Constants
if DEBUG then
    wdPrint(wdConstants.name)
end
return wdConstants
