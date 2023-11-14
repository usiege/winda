-- get theme resources root path
-- if changes, user can replace a new root Path
-- which contain all resources (font, sound, texture)
-- new file must has same name to source
function wdGetThemeResRootPath(themename)
    -- body...
    if themename == nil or themename == "" then
        --body...
        return "Interface/Addons/winda/theme/base"
    end
    return "Interface/Addons/winda/theme/"..themename
end

