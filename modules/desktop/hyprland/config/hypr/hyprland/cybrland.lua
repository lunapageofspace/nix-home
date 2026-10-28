---------------------------------------
-- cybrcore    lucid theme config for hyprland
-- Project:    https://github.com/cybrcore/cybr-hyprland
-- Author:     scherrer-txt   |   License:     GPL-3.0
-- Source:     ~/.config/hypr/theme.lua
---------------------------------------

local variables = require("hyprland/variables")

local colors = {
    -- BLACK
    no0 = "030408",
    no1 = "05070D",
    no2 = "0A0E1A",
    -- RED
    re0 = "F24848",
    re1 = "631F21",
    re2 = "331215",
    -- GREEN
    gr0 = "30F291",
    gr1 = "15633F",
    gr2 = "0C3423",
    -- YELLOW
    ye0 = "F2D230",
    ye1 = "635618",
    ye2 = "332D10",
    -- BLUE
    bl0 = "3061F2",
    bl1 = "152966",
    bl2 = "0C1737",
    -- VIOLET
    vi0 = "A130F2",
    vi1 = "421666",
    vi2 = "230D37",
    -- CYAN
    cy0 = "29BECC",
    cy1 = "124E56",
    cy2 = "0B292F",
    -- WHITE
    wh0 = "898D99",
    wh1 = "393B42",
    wh2 = "1E2025",
    -- GREY
    me0 = "4D5A80",
    me1 = "212638",
    me2 = "0D1120",
    -- ORANGE
    or0 = "F26118",
    or1 = "63290E",
    or2 = "33170B",
    -- PINK
    pi0 = "F230B2",
    pi1 = "63164C",
    pi2 = "330D2A",
    -- TRANSPARENCY
    tr0 = "00",
    tr2 = "20",
    tr5 = "50",
    tr7 = "70",
    trF = "FF", -- FULL
}


for k, v in pairs(variables) do _G[k] = v end
for k, v in pairs(colors) do _G[k] = v end

-- DECORATION
hl.config({
    general = {
        border_size = border,
        col = {
            inactive_border = "rgba(" .. cy0 .. tr0 .. ")",
            active_border = "rgba(" .. re0 .. trF .. ")",
        },
        gaps_in = gapS,
        gaps_out = gapM,
    },
    decoration = {
        rounding = radius,
        rounding_power = power,
        active_opacity = activeTr,
        inactive_opacity = inActiveTr,
        blur = {
            enabled = true,
            size = blurSize,
            passes = blurPass,
            noise = noise,
            ignore_opacity = true,
            new_optimizations = true,
            xray = false,
            popups = true,
        },
        shadow = {
            enabled = false,
            range = 10,
            scale = 20,
            render_power = 2,
            color = "rgba(" .. re0 .. tr2 .. ")",
            color_inactive = "rgba(" .. no0 .. tr2 .. ")",
        },
        dim_inactive = false,
        dim_strength = 1,
        dim_special = 0,
    },
    group = {
        col = {
            border_active = "rgba(" .. re0 .. trF .. ")",
            border_inactive = "rgba(" .. re1 .. trF .. ")",
            border_locked_active = "rgba(" .. vi0 .. trF .. ")",
            border_locked_inactive = "rgba(" .. vi0 .. tr7 .. ")",
        },
        groupbar = {
            col = {
                active = "rgba(" .. re0 .. trF .. ")",
                inactive = "rgba(" .. re1 .. trF .. ")",
                locked_active = "rgba(" .. vi0 .. trF .. ")",
                locked_inactive = "rgba(" .. vi0 .. tr7 .. ")",
            },
            font_size = fontM,
            text_color = "rgba(" .. no0 .. trF .. ")",
            height = 1,
            indicator_height = 24,
            text_offset = -12,
        },
    },

-- ANIMATIONS
    animations = {
        enabled = false,
    },
})
