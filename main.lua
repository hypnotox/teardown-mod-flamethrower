--[[
#include "scripts/flamethrower.lua"
#include "scripts/flame.lua"
#include "scripts/flameManager.lua"
#include "scripts/particleManager.lua"
#include "scripts/soundManager.lua"
#include "lib/debug.lua"
]]

function init()
    -- Must be disabled when publishing
    --Debug:enable()
    Flamethrower:init()
end

function tick(dt)
    if GetString("game.player.tool") == "hypnotox_flamethrower" and GetBool("game.player.canusetool") then
        Flamethrower:tick(dt)
        Debug:tick()
    end
end
