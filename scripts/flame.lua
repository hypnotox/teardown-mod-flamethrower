Flame = {}

function Flame:new(nozzle, fwd, lifetime, maxDist)
    local instance = {
        transform = TransformCopy(nozzle),
        fwd = fwd,
        lifetime = lifetime,
        dist = 0,
        maxDist = maxDist,
    }

    setmetatable(instance, self)
    self.__index = self
    return instance
end

function Flame:tick()
    local travelledDist = self.fwd * GetTimeStep()
    local size = (self.dist / self.fwd) * 1.5

    if size < 0 then
        size = 0.05
    end

    PointLight(self.transform.pos, 1, 0.3, 0.1, size)

    for j = 1, 20, 1 do
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