Flame = {}

function Flame:new(nozzle, dist)
    local instance = {
        transform = TransformCopy(nozzle),
        distance = 0,
        maxDistance = dist
    }

    setmetatable(instance, self)
    self.__index = self
    return instance
end

function Flame:tick(dt, distance)
    local size = self.distance / 8
    PointLight(self.transform.pos, 1, 0.7, 0.3, size)

    for j = 1, 10, 1 do
        local point = self:randomPoint(size)
        SpawnFire(point)
    end

    self.transform = TransformToParentTransform(self.transform, Transform(Vec(0, 0, -distance)))
    self.distance = self.distance + distance
end

function Flame:randomPoint(radius)
    local radius = radius * 100
    local offsetLength = math.random(-radius, radius) / 100
    local offsetRotation = QuatEuler(math.random(0, 360), math.random(0, 360), math.random(0, 360))

    return VecAdd(self.transform.pos, QuatRotateVec(offsetRotation, Vec(0, 0, offsetLength)))
end