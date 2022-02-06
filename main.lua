--[[
-- Libraries
#include "lib/engine.lua"
#include "lib/debug.lua"

-- Entities
#include "src/scripts/entities/flame.lua"
#include "src/scripts/knob.lua"

-- Managers
#include "src/scripts/managers/flameManager.lua"
#include "src/scripts/managers/particleManager.lua"
#include "src/scripts/managers/soundManager.lua"

-- Base
#include "src/scripts/flamethrower.lua"
]]

function init()
    -- Must be disabled when publishing
    Debug:enable()
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
