--[[
-- Libraries
#include "scripts/lib/input.lua"
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

local initialized = false

function initializeDependencies()
    initInput()
    initEngine()
    initDebug()
    initFlame()
    initSoundManager()
    initFlamethrower()
    initKnob()
    initNozzle()
    initFireStarter()
    initialized = true
end

function init()
    initializeDependencies()

    -- Must be disabled when publishing
    -- Debug:init()

    if GetBool('savegame.mod.features.fire_limit.enabled') then
        SetInt("game.fire.maxcount", GetInt('savegame.mod.features.fire_limit.value') or 1000000)
    end
end

function tick()
    if not initialized then
        initializeDependencies()
    end

    if GetString("game.player.tool") == "hypnotox_flamethrower" then
        Debug:tick()
        Flamethrower:tick()
    end
end

function update()
    if not initialized then
        initializeDependencies()
    end

    if GetString("game.player.tool") == "hypnotox_flamethrower" and GetBool("game.player.canusetool") then
        Flamethrower:update()
    end
end
