-- contant settings
local Constants = {
    name = "constant";
    -- gui
    gui_window_width    = 1000,
    gui_window_height   = 800,
    gui_window_level    = 10,
    gui_border_pad      = 5,
    -- list and item
    gui_list_width      = 200,
    gui_list_height     = 800, 
    -- gui_item_width      = 180,
    -- gui_item_height     = 33,
    -- gui_item_padding    = 7,
    -- logo
    gui_logo_width      = 120,
    gui_logo_height     = 60,
    gui_logo_point      = {36, 15},
    -- version
    gui_version_width   = 100,
    gui_version_height  = 30,
    gui_version_point   = {10, 10},
    gui_version_text_size = 12,

    -- gui refer 
    gui_entity = {
        index_referto_point     = {10, -88},
        
        index_padding_width     = 0,
        index_padding_height    = 8,
        index_button_width      = 180,
        index_button_height     = 32,

        arrow_width             = 128,
        arrow_height            = 32,

        setting_item_width      = 800,
        setting_item_height     = 750,
        setting_topright_point  = {0, 0},
    },
    
}

wdConstants = Constants
wdPrint(wdConstants.name)
WDC = wdConstants

return wdConstants
