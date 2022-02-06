Flame = {}

function Flame:new(nozzle, fwd, lifetime, hit, maxDist, normal)
    local instance = {
        transform = TransformCopy(nozzle),
        fwd = fwd * 0.8,
        lifetime = lifetime * 0.9,
        dist = 0,
        hit = hit,
        maxDist = maxDist,
        normal = normal,
        isAlive = true
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
    local size = (self.dist * 2) / self.fwd

    if size < 0 then
        size = 0.05
    end

    if self.hit then
        local distToWall = self.maxDist - self.dist

        if distToWall < 0.1 then
            distToWall = 0.1
        end

        if distToWall < 0.2 then
            size = size / (distToWall * 5)
        end
    end

    local samplePoints = tonumber(size * 50)

    for _ = 1, samplePoints, 1 do
        local point = self:randomPoint(size)
        SpawnFire(point)
        Debug:cross(point, 255, 0, 0, 0.7)
    end

    if self.lifetime < 0 or self.dist > self.maxDist then
        self.isAlive = false
    end

    local travelledDist = self.fwd * GetTimeStep()
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