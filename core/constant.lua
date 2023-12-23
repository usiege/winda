local UIConstants = {
    scale = 1,

}

-- contant settings for gui
local GUIConstants = {
    name = "constant";
    -- gui
    window_width    = 800,
    window_height   = 600,
    window_min_resize = {400, 300},
    window_max_resize = {1000, 800},
    window_level    = 10,
    border_pad      = 5,

    -- list and item
    list_width      = 160,
    list_height     = 600-5*2, 
    -- gui_item_width      = 180,
    -- gui_item_height     = 33,
    -- gui_item_padding    = 7,
    right_bg_width = 800-160-5*3,
    right_bg_height = 600-5*2,

    -- logo
    logo_width      = 105,
    logo_height     = 50,
    logo_point      = {28, 5},

    -- version
    version_width   = 100,
    version_height  = 30,
    version_point   = {10, 10},
    version_text_size = 15,

    -- gui entity 
    entity = {
        -- left sub
        index_referto_point     = {0, 58}, -- first item button position
        
        index_padding_width     = 0,
        index_padding_height    = 8,
        index_button_width      = 130,
        index_button_height     = 24,

        -- arrow
        arrow_width             = 120,
        arrow_height            = 24,

        -- right sub
        setting_item_width      = 600,
        setting_item_height     = 480,
        setting_topright_point  = {0, 57},
    },

    -- url copy
    url_copy = {
        bg_width            = 400,
        bg_height           = 60,

        text_width          = 380,
        text_height         = 20,
        text_point          = {0, 10},

        close_width         = 70,
        close_height        = 18,
        close_point         = {10, 10},
    },

    -- title label
    title = {
        width               = 200,
        height              = 60,
        point               = {0, 0},
        text_size           = 20,
    },

    -- gui cocreate
    cocreate = {
        logo_width              = 230,
        logo_height             = 85,
        logo_point              = {0, 10},

        text_width              = 400,
        text_height             = 60,
        text_point              = {0, 100},
        text_size               = 20,

        button_width            = 360,
        button_height           = 45,

        button_padding_y        = 15,
        button_referto_point    = {0, 150},
    },
    -- gui about
    about = {
        text_width              = 200,
        text_height             = 30,
        text_point              = {0, 130},
        text_size               = 20,

        wow_text_point          = {0, 20},
    }, 

    
    
}

-- for actionbar 
local ActionBarContants = {
    name = "action constant"
}


WDC = UIConstants
wdPrint(WDC.name)

WDC.GUI = GUIConstants
WDC.ABC = ActionBarContants

return WDC
