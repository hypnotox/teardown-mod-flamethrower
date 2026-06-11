-- State: the authoritative data seam (future multiplayer `shared` table).
-- Holds only the values the version-2 MP model auto-syncs server->client:
-- per-player ammo and knob flame velocity. Accessed exclusively through these
-- accessors so the backing store (today: a game property + a serialized field)
-- can later become the engine `shared` table. Simulation is the only writer;
-- Presentation only reads. See ../../docs/reference/multiplayer.md.
State = {
    -- Ammo
    maxAmmo = 100,
    ammoPerSecond = 5,

    -- Flame velocity (knob). Clamped only by Simulation:applyVelocityDelta.
    -- A field on the global State table, so Teardown's quicksave _G snapshot
    -- restores the player's value over this default on quickload (the same
    -- mechanism the old Knob.flameVelocity relied on).
    flameVelocity = 15,
    flameVelocityDefault = 15,
    flameVelocityMin = 5,
    flameVelocityMax = 25,
}

local AMMO_KEY = 'game.tool.hypnotox_flamethrower.ammo'

-- Ammo is backed by the engine tool property so the built-in HUD keeps working.
function State:getAmmo()
    return GetFloat(AMMO_KEY)
end

function State:hasAmmo()
    return GetInt(AMMO_KEY) > 0
end

function State:setAmmo(value)
    SetFloat(AMMO_KEY, value)
end

function State:fillAmmo()
    SetFloat(AMMO_KEY, self.maxAmmo)
end

-- Flame velocity. Plain storage; clamping lives in Simulation.
function State:getFlameVelocity()
    return self.flameVelocity
end

function State:setFlameVelocity(value)
    self.flameVelocity = value
end
