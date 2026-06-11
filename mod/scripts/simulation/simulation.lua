-- Simulation: authoritative game logic and world mutation (future multiplayer
-- `server`). Everything here maps to serveronly territory: RegisterTool,
-- SpawnFire (via Flame), the fire-limit override, and ammo bookkeeping. The two
-- entry points fire()/applyVelocityDelta() are the future ServerCall targets.
-- See ../../../docs/reference/multiplayer.md.
Simulation = {
    flames = {}
}

-- Idempotent engine-side setup, safe to re-run on quickload. Registers and
-- enables the tool. Does NOT set ammo (that is fresh-start state in :init()).
function Simulation:setup()
    self:register()
end

function Simulation:register()
    local modelPath = 'MOD/vox/Flamethrower.vox'
    local inventorySlot = Registry.getIntOr('savegame.mod.features.inventory.slot', 6)

    -- NOTE: reads Debug.enabled (a client-ish flag) to pick the voxel model,
    -- because RegisterTool takes the model path. multiplayer.md lists tool
    -- registration in MP as an open question; revisit during the actual port.
    if Debug.enabled then
        modelPath = 'MOD/vox/FlamethrowerDebug.vox'
    end

    Debug:dump(inventorySlot, 'Slot')

    RegisterTool('hypnotox_flamethrower', 'Flamethrower', modelPath, inventorySlot)
    SetBool('game.tool.hypnotox_flamethrower.enabled', true)
end

-- Fresh-start state: only on a new level, never re-applied on quickload, so a
-- restored partial-ammo save is preserved. Called from init(), not setup().
function Simulation:init()
    State:fillAmmo()

    if GetBool('savegame.mod.features.fire_limit.enabled') then
        SetInt("game.fire.maxcount", GetInt('savegame.mod.features.fire_limit.value') or 1000000)
    end
end

-- No server-side variable-dt work yet; placeholder mirroring the future
-- server.tick. Flame advance is fixed-step, in :update().
function Simulation:tick()
end

-- Fixed-timestep authoritative step: advance every flame and cull the dead.
function Simulation:update()
    for i = #self.flames, 1, -1 do
        Flame.advance(self.flames[i])

        if not self.flames[i].isAlive then
            table.remove(self.flames, i)
        end
    end
end

-- Future ServerCall target. Spawn a flame from client-supplied firing params:
--   { transform = <nozzle world transform>, speed = <scalar>, lifetime = <seconds> }
-- The server derives direction from the transform, raycasts, and consumes ammo.
function Simulation:fire(params)
    if not State:hasAmmo() then
        return
    end

    local dir = TransformToParentVec(params.transform, Vec(0, 0, -1))
    local hit, maxDist, normal = QueryRaycast(params.transform.pos, dir, 100)

    table.insert(self.flames, Flame.new(params.transform, params.speed, params.lifetime * 0.5, hit, maxDist, normal))
    self:consumeAmmo()
end

-- Per-active-frame ammo drain (the old Flamethrower:ammoTick).
function Simulation:consumeAmmo()
    local ammoUsed = State.ammoPerSecond * GetTimeStep()
    State:setAmmo(State:getAmmo() - ammoUsed)
end

-- Future ServerCall target. Apply a clamped change to the knob flame velocity.
function Simulation:applyVelocityDelta(delta)
    local value = State:getFlameVelocity() + delta
    value = math.max(State.flameVelocityMin, math.min(State.flameVelocityMax, value))
    State:setFlameVelocity(value)
end

function Simulation:getFlames()
    return self.flames
end
