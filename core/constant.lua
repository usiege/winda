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
    gui_list_height     = 800-5*2, 
    -- gui_item_width      = 180,
    -- gui_item_height     = 33,
    -- gui_item_padding    = 7,
    gui_right_bg_width = 1000-200-5*3,
    gui_right_bg_height = 800-5*2,

    -- logo
    gui_logo_width      = 160,
    gui_logo_height     = 80,
    gui_logo_point      = {36, 5},
    -- version
    gui_version_width   = 100,
    gui_version_height  = 30,
    gui_version_point   = {10, 10},

    gui_version_text_size = 15,

    -- gui refer 
    gui_entity = {
        index_referto_point     = {10, -88}, -- first item button position
        
        index_padding_width     = 0,
        index_padding_height    = 8,
        index_button_width      = 180,
        index_button_height     = 32,

        arrow_width             = 128,
        arrow_height            = 32,

        setting_item_width      = 600,
        setting_item_height     = 600,
        setting_topright_point  = {0, 80},
    },

    -- gui cocreate
    gui_cocreate = {
        logo_width              = 300,
        logo_height             = 150,
        logo_point              = {0, 10},

        button_width            = 512,
        button_height           = 64,

        button_padding_y        = 15,
        button_referto_point    = {0, 150},
    },

    -- url copy
    url_copy = {
        bg_width            = 400,
        bg_height           = 60,

        text_width          = 380,
        text_height         = 20,
        text_point          = {0, -10},

        close_width         = 70,
        close_height        = 18,
        close_point         = {-10, 10},
    },
    
}
local ActionBarContants = {
    name = "action constant"
}


wdConstants = Constants
wdPrint(wdConstants.name)

WDC = wdConstants
WDC.ABC = ActionBarContants

return wdConstants
