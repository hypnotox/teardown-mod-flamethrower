--[[
-- Libraries
#include "scripts/lib/engine.lua"
#include "scripts/lib/debug.lua"

-- Entities
#include "scripts/entities/flame.lua"

-- Managers
#include "scripts/managers/soundManager.lua"

-- Base
#include "scripts/flamethrower.lua"
#include "scripts/knob.lua"
#include "scripts/nozzle.lua"
#include "scripts/fireStarter.lua"
]]

function init()
    -- Must be disabled when publishing
    --Debug:enable()
    Debug:init()
    Flamethrower:init()

    if GetBool('savegame.mod.features.fire_limit.enabled') then
        SetInt("game.fire.maxcount", GetInt('savegame.mod.features.fire_limit.value') or 1000000)
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
