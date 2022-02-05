--[[
#include "scripts/flamethrower.lua"
#include "scripts/flame.lua"
#include "scripts/flameManager.lua"
#include "scripts/particleManager.lua"
#include "scripts/soundManager.lua"
#include "scripts/knob.lua"
#include "lib/debug.lua"
]]

function init()
    -- Must be disabled when publishing
    --Debug:enable()
    Flamethrower:init()
    SetInt("game.fire.maxcount", 1000000)
end

function tick(dt)
    if GetString("game.player.tool") == "hypnotox_flamethrower" and GetBool("game.player.canusetool") then
        Flamethrower:tick(dt)
        Debug:tick()
    end
end

function update()
    if GetString("game.player.tool") == "hypnotox_flamethrower" and GetBool("game.player.canusetool") then
        Flamethrower:update()
    end
end
