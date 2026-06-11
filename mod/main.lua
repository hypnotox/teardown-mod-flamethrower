--[[
-- Libraries
#include "scripts/lib/registry.lua"
#include "scripts/lib/engine.lua"
#include "scripts/lib/debug.lua"

-- State (shared seam)
#include "scripts/state.lua"

-- Simulation (server)
#include "scripts/simulation/flame.lua"
#include "scripts/simulation/simulation.lua"

-- Presentation (client)
#include "scripts/presentation/nozzle.lua"
#include "scripts/presentation/fireStarter.lua"
#include "scripts/presentation/knob.lua"
#include "scripts/presentation/flameLight.lua"
#include "scripts/presentation/sound.lua"
#include "scripts/presentation/tool.lua"
#include "scripts/presentation/presentation.lua"
]]

local engineSetupDone = false

-- Re-establishes engine-side bindings that do not survive serialization. Safe to
-- run on every script (re-)execution, including quickload; must never touch
-- gameplay-progress state (see init() / Simulation:init()). Fans out to both
-- layers -- the future server.* and client.* setup.
local function setup()
    engineSetupDone = true

    -- Driven by the options toggle. Read before Simulation:setup() so the debug
    -- voxel model is picked up at registration. Applies on (re)load, not mid-session.
    Debug.enabled = GetBool('savegame.mod.features.debug.enabled')

    Simulation:setup()
    Presentation:setup()
end

function init()
    setup()

    -- Fresh-start state: only on a new level, never re-applied on quickload.
    -- Presentation:init re-captures the knob default; Simulation:init fills ammo
    -- and applies the fire-limit override.
    Presentation:init()
    Simulation:init()
end

function tick()
    if not engineSetupDone then
        setup()
    end

    if GetString("game.player.tool") ~= "hypnotox_flamethrower" then
        return
    end

    Debug:tick()
    -- No-op today; reserved for server.tick (variable-dt server work) in the
    -- multiplayer split. Flame physics advance is fixed-step, in Simulation:update.
    Simulation:tick()
    Presentation:tick()
end

function update()
    if not engineSetupDone then
        setup()
    end

    if GetString("game.player.tool") ~= "hypnotox_flamethrower" or not GetBool("game.player.canusetool") then
        return
    end

    -- Client produces intent first (build firing params -> Simulation:fire,
    -- knob delta -> Simulation:applyVelocityDelta), then the server advances the
    -- simulation -- mirroring the future client -> server message flow.
    Presentation:update()
    Simulation:update()
end
