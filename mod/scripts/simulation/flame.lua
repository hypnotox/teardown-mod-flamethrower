-- Flame: a single in-flight flame, plain data (no metatable) so it survives
-- quickload intact (see ../../../docs/reference/save-load.md) and so the shape is
-- already right for moving server-side under multiplayer. Flame.new / Flame.advance
-- are file-scope functions, not methods, on purpose. Simulation owns these; the
-- SpawnFire emission here is serveronly in multiplayer.
--
-- Model: velocity-vector integration with per-step raycast collision. Each step
-- moves pos by vel*dt, applies gravity + drag, and spawns fire in a growing
-- sphere around pos. Reflection, surface creep, and turbulent wander are layered
-- on in later tasks. All feel/cost tuning lives in the constants below.
Flame = {}

-- === Tunable physics constants ===
local GRAVITY_STRENGTH = 5      -- m/s^2 downward (gentle droop; real gravity is 9.81)
local DRAG             = 0.2    -- per-second velocity decay (the original 0.2/s, now on the vector)
local SIZE_GROWTH      = 1.5    -- spawn-sphere radius growth factor (matches the original)
local MAX_FIRE_POINTS  = 20     -- per-flame-per-frame SpawnFire cap (cost guard)
local MIN_SPEED        = 2      -- m/s; below this the flame dies
local SURFACE_OFFSET   = 0.05   -- m; nudge out of a surface on impact

-- A random point inside a sphere of radius r around center.
local function randomSpherePoint(center, r)
    local offsetRotation = QuatEuler(math.random(0, 360), math.random(0, 360), math.random(0, 360))
    local offsetLength = math.random(0, math.floor(r * 100)) / 100
    return VecAdd(center, QuatRotateVec(offsetRotation, Vec(0, 0, offsetLength)))
end

-- Spawn this flame's fires in a growing sphere around its position.
local function spawnFireVolume(flame, speed)
    local size = (flame.dist * SIZE_GROWTH) / speed
    if size < 0.05 then
        size = 0.05
    end

    local samplePoints = math.min(MAX_FIRE_POINTS, math.ceil(size * 10))

    for _ = 1, samplePoints, 1 do
        local point = randomSpherePoint(flame.pos, size)
        SpawnFire(point)
        Debug:cross(point, 150, 0, 255, 1)
    end
end

---Create a flame as plain data (no metatable) so it survives quickload intact.
---@return table
function Flame.new(pos, vel, lifetime)
    return {
        pos = VecCopy(pos),
        vel = VecCopy(vel),
        lifetime = lifetime,
        dist = 0,
        bounces = 0,
        isAlive = true
    }
end

-- Advance one fixed step: collide, integrate forces, spawn fire, age.
-- Sets flame.isAlive = false when spent.
function Flame.advance(flame)
    local dt = GetTimeStep()
    local speed = VecLength(flame.vel)
    local step = VecScale(flame.vel, dt)
    local stepLen = VecLength(step)
    local moved = stepLen

    -- Per-step collision: raycast along this frame's displacement.
    if stepLen > 0 then
        local dir = VecScale(step, 1 / stepLen)
        local hit, hitDist = QueryRaycast(flame.pos, dir, stepLen)

        if hit then
            -- Stop at the surface and die (reflection is added in Task 2).
            flame.pos = VecAdd(flame.pos, VecScale(dir, hitDist))
            flame.isAlive = false
            moved = hitDist
        else
            flame.pos = VecAdd(flame.pos, step)
        end
    end

    -- Forces: gravity droop, then drag.
    flame.vel = VecAdd(flame.vel, Vec(0, -GRAVITY_STRENGTH * dt, 0))
    flame.vel = VecScale(flame.vel, 1 - DRAG * dt)

    -- Emit fire and age. spawnFireVolume uses this step's pre-force speed on
    -- purpose: density should match the speed the flame actually travelled this
    -- frame. A flame that just crossed MIN_SPEED still emits one final burst.
    spawnFireVolume(flame, speed)
    flame.dist = flame.dist + moved
    flame.lifetime = flame.lifetime - dt

    if flame.lifetime <= 0 or VecLength(flame.vel) < MIN_SPEED then
        flame.isAlive = false
    end
end
