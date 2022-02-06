--[[
#include "src/scripts/flamethrower.lua"
#include "src/scripts/flame.lua"
#include "src/scripts/flameManager.lua"
#include "src/scripts/particleManager.lua"
#include "src/scripts/soundManager.lua"
#include "src/scripts/knob.lua"
#include "lib/debug.lua"
]]

function init()
    -- Must be disabled when publishing
    --Debug:enable()
    Flamethrower:init()

    if GetBool('savegame.mod.features.fire_limit.enabled') then
        SetInt("game.fire.maxcount", GetInt('savegame.mod.features.fire_limit.value'))
    end
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
