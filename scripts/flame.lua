Flame = {}

function Flame:new(nozzle, fwd, lifetime, hit, maxDist, normal)
    local instance = {
        transform = TransformCopy(nozzle),
        fwd = fwd * 0.8,
        lifetime = lifetime * 0.8,
        dist = 0,
        hit = hit,
        maxDist = maxDist,
        normal = normal
    }

    setmetatable(instance, self)
    self.__index = self
    return instance
end

function Flame:tick()
    local size = ((self.dist * 2) / self.fwd) * 1.5
    PointLight(self.transform.pos, 1, 0.3, 0.1, size)
end

function Flame:update()
    local travelledDist = self.fwd * GetTimeStep()
    local size = ((self.dist * 2) / self.fwd) * 1.5

    if size < 0 then
        size = 0.05
    end

    for _ = 1, 20, 1 do
        local point = self:randomPoint(size)
        SpawnFire(point)
        Debug:cross(point)
    end

    self.transform = TransformToParentTransform(self.transform, Transform(Vec(0, 0, -travelledDist)))
    self.dist = self.dist + travelledDist
    self.lifetime = self.lifetime - GetTimeStep()
end

function Flame:randomPoint(r)
    local radius = r * 100
    local offsetLength = math.random(-radius, radius) / 100
    local offsetRotation = QuatEuler(math.random(0, 360), math.random(0, 360), math.random(0, 360))

    return VecAdd(self.transform.pos, QuatRotateVec(offsetRotation, Vec(0, 0, offsetLength)))
end