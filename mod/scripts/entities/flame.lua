Flame = {}

local function randomPoint(transform, r)
    local radius = r * 100
    local offsetLength = math.random(-radius, radius) / 100
    local offsetRotation = QuatEuler(math.random(0, 360), math.random(0, 360), math.random(0, 360))

    return VecAdd(transform.pos, QuatRotateVec(offsetRotation, Vec(0, 0, offsetLength)))
end

---Create a flame as plain data (no metatable) so it survives quickload intact.
---@return table
function Flame.new(nozzle, fwd, lifetime, hit, maxDist, normal)
    return {
        transform = TransformCopy(nozzle),
        fwd = fwd,
        lifetime = lifetime,
        dist = 0,
        hit = hit,
        maxDist = maxDist,
        normal = normal,
        isAlive = true
    }
end

function Flame.tick(flame)
    local size = ((flame.dist * 2) / flame.fwd)
    PointLight(flame.transform.pos, 1, 0.2, 0.01, size)
end

function Flame.update(flame)
    local size = (flame.dist * 1.5) / flame.fwd

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

    local travelledDist = flame.fwd * GetTimeStep()
    flame.transform = TransformToParentTransform(flame.transform, Transform(Vec(0, 0, -travelledDist)))
    flame.dist = flame.dist + travelledDist
    flame.lifetime = flame.lifetime - GetTimeStep()
    flame.fwd = flame.fwd - ((flame.fwd * 0.2) * GetTimeStep())
end
