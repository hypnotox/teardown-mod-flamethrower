Nozzle = {}

local flameVelocityHigh
local flameVelocityMedium
local flameVelocityLow

local function spawnAtPosition(pos, lifetime)
    SpawnParticle(pos, flameVelocityHigh, lifetime)
    SpawnParticle(pos, flameVelocityMedium, lifetime * 0.8)
    SpawnParticle(pos, flameVelocityLow, lifetime * 0.7)
end

local function spawnParticles(flameVelocity, lifetime)
    local nozzle = Nozzle:getNozzleTransform()
    local startSize = 0.03
    local endSize = 1

    flameVelocityHigh = VecAdd(flameVelocity, VecScale(direction, 30))
    flameVelocityMedium = VecAdd(flameVelocity, VecScale(direction, 25))
    flameVelocityLow = VecAdd(flameVelocity, VecScale(direction, 20))

    ParticleReset()
    ParticleSticky(0.1)
    ParticleCollide(0, 0.001)
    ParticleGravity(5, -10)
    ParticleDrag(0)
    ParticleStretch(3)
    ParticleTile(5)

    -- white core
    ParticleColor(1, math.random(9, 10) / 10, math.random(9, 10) / 10)
    ParticleEmissive(2, 0)
    ParticleRadius(startSize, endSize)
    ParticleAlpha(0.8, 0.5)
    spawnAtPosition(nozzle.pos, lifetime)

    -- orange tint
    ParticleColor(1, math.random(28, 44) / 100, 0)
    ParticleEmissive(6, 0)
    ParticleRadius(startSize * 1.5, endSize * 1.5)
    ParticleAlpha(0.8, 0.5)
    spawnAtPosition(nozzle.pos, lifetime)

    -- red splatter
    ParticleColor(1, math.random(5, 15) / 100, 0)
    ParticleEmissive(4, 0)
    ParticleRadius(startSize * 1.5, endSize * 1.7)
    ParticleAlpha(0.3, 0.7)
    spawnAtPosition(nozzle.pos, lifetime)

    -- red cloud
    ParticleColor(1, math.random(40, 50) * 0.01, 0, 1, math.random(20, 40) * 0.01, 0)
    ParticleEmissive(3, 0)
    ParticleRadius(startSize * 1.5, endSize * 2.5)
    ParticleAlpha(0.8, 0.5)
    spawnAtPosition(nozzle.pos, lifetime)
end

function Nozzle:getFlameVelocity()
    local nozzle = self:getNozzleTransform()
    local direction = TransformToParentVec(nozzle, Vec(0, 0, -1))
    direction = VecAdd(direction, TransformToParentVec(GetPlayerTransform()))

    return VecScale(direction, Knob.flameVelocity * 2)
end

function Nozzle:getNozzleShape()
    local tool = GetToolBody()
    local shapes = GetBodyShapes(tool)

    return shapes[4]
end

function Nozzle:getNozzleTransform()
    local shape = self:getNozzleShape()
    local transform = GetShapeWorldTransform(shape)
    local tool = GetToolBody()
    local toolTransform = GetBodyTransform(tool)

    return TransformToParentTransform(
        Transform(transform.pos, toolTransform.rot),
        Engine:voxelCenterOffset()
    )
end

function Nozzle:throwFlames(flameVelocity, lifetime)
    if InputDown('usetool') then
        local nozzle = self:getNozzleTransform()
        local fwd = TransformToParentVec(nozzle, Vec(0, 0, -1))
        local hit, maxDist, normal = QueryRaycast(nozzle.pos, fwd, 30, 0.10)

        table.insert(Flamethrower.flames, Flame:new(nozzle, VecLength(flameVelocity), lifetime * 0.5, hit, maxDist, normal))
        Flamethrower:ammoTick()
        spawnParticles(flameVelocity, lifetime)
    end
end
