--[[
-- Libraries
#include "scripts/lib/registry.lua"
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

local engineSetupDone = false

-- Re-establishes engine-side bindings that do not survive serialization.
-- Safe to run on every script (re-)execution, including quickload; must never
-- touch gameplay-progress state (see init()).
local function setup()
    engineSetupDone = true

    -- Uncomment to enable the debug overlay (HOME toggles in-game).
    -- Must be disabled when publishing.
    -- Debug:init()

    SoundManager:load()
    Knob:loadConfig()
    Flamethrower:register()
end

function init()
    setup()

    -- Fresh-start gameplay state: only on a new level, never re-applied on
    -- quickload, so a restored partial-ammo save is preserved.
    SetFloat('game.tool.hypnotox_flamethrower.ammo', Flamethrower.maxAmmo)

    if GetBool('savegame.mod.features.fire_limit.enabled') then
        SetInt("game.fire.maxcount", GetInt('savegame.mod.features.fire_limit.value') or 1000000)
    end
end

function tick()
    if not engineSetupDone then
        setup()
    end

    if GetString("game.player.tool") == "hypnotox_flamethrower" then
        Debug:tick()
        Flamethrower:tick()
    end
end

function update()
    if not engineSetupDone then
        setup()
    end

    if GetString("game.player.tool") == "hypnotox_flamethrower" and GetBool("game.player.canusetool") then
        Flamethrower:update()
    end
end
