-- Flame: a single in-flight flame, plain data (no metatable) so it survives
-- quickload intact (see ../../../docs/reference/save-load.md) and so the shape is
-- already right for moving server-side under multiplayer. Flame.new / Flame.advance
-- are file-scope functions, not methods, on purpose. Simulation owns these; the
-- SpawnFire emission here is serveronly in multiplayer.
Flame = {}

local function randomPoint(transform, r)
    local radius = r * 100
    local offsetLength = math.random(-radius, radius) / 100
    local offsetRotation = QuatEuler(math.random(0, 360), math.random(0, 360), math.random(0, 360))

    return VecAdd(transform.pos, QuatRotateVec(offsetRotation, Vec(0, 0, offsetLength)))
end

---Create a flame as plain data (no metatable) so it survives quickload intact.
---@return table
function Flame.new(nozzle, speed, lifetime, hit, maxDist, normal)
    return {
        transform = TransformCopy(nozzle),
        speed = speed,
        lifetime = lifetime,
        dist = 0,
        hit = hit,
        maxDist = maxDist,
        normal = normal,
        isAlive = true
    }
end

-- Advance one fixed step: spawn fires along the path, age, and move forward.
-- Sets flame.isAlive = false when spent.
function Flame.advance(flame)
    local size = (flame.dist * 1.5) / flame.speed

    if size < 0 then
        size = 0.05
    end

    local samplePoints = math.ceil(size * 10)

    for _ = 1, samplePoints, 1 do
        local point = randomPoint(flame.transform, size)
        SpawnFire(point)
        Debug:cross(point, 150, 0, 255, 1)
    end

    if flame.lifetime < 0 or flame.dist > flame.maxDist then
        flame.isAlive = false
    end

    local travelledDist = flame.speed * GetTimeStep()
    flame.transform = TransformToParentTransform(flame.transform, Transform(Vec(0, 0, -travelledDist)))
    flame.dist = flame.dist + travelledDist
    flame.lifetime = flame.lifetime - GetTimeStep()
    flame.speed = flame.speed - ((flame.speed * 0.2) * GetTimeStep())
end
