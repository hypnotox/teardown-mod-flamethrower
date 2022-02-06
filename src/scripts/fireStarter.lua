FireStarter = {}

function FireStarter:getShape()
    local tool = GetToolBody()
    local shapes = GetBodyShapes(tool)

    return shapes[3]
end

function FireStarter:getFireStarterTransform()
    local shape = self:getShape()
    local transform = GetShapeWorldTransform(shape)
    local tool = GetToolBody()
    local toolTransform = GetBodyTransform(tool)

    return TransformToParentTransform(
        Transform(transform.pos, toolTransform.rot),
        Engine:voxelCenterOffset()
    )
end

local nozzleFlameVelocityHigh
local nozzleFlameVelocityLow

local function spawnAtPosition(pos, lifetime)
    SpawnParticle(pos, nozzleFlameVelocityHigh, lifetime)
    SpawnParticle(pos, nozzleFlameVelocityLow, lifetime * 1.7)
end

function FireStarter:spawnParticles()
    ParticleReset()
    local shape = self:getShape()
    local transform = GetShapeWorldTransform(shape)
    local tool = GetToolBody()
    local toolTransform = GetBodyTransform(tool)

    local fireStarter = TransformToParentTransform(
        Transform(transform.pos, toolTransform.rot),
        Engine:voxelCenterOffset()
    )
    local direction

    if InputDown('usetool') then
        direction = TransformToParentVec(fireStarter, Vec(-0.3, 0.7, 0))
        ParticleGravity(0, -10)
    else
        direction = TransformToParentVec(fireStarter, Vec(0, 0.7, 0))
        ParticleGravity(5, 10)
    end

    nozzleFlameVelocityHigh = VecAdd(direction, VecScale(direction, 0.2))
    nozzleFlameVelocityLow = VecAdd(direction, VecScale(direction, 0.05))

    ParticleSticky(0)
    ParticleCollide(0)
    ParticleGravity(5, 10)
    ParticleDrag(0)
    ParticleTile(5)
    ParticleEmissive(2, 0)
    ParticleAlpha(0.7, 0)

    -- white core
    ParticleColor(1, math.random(9, 10) / 10, math.random(9, 10) / 10)
    ParticleRadius(0.03, 0.01)
    spawnAtPosition(fireStarter.pos, 0.1)

    -- orange tint
    ParticleColor(1, math.random(28, 44) / 100, 0)
    ParticleRadius(0.06, 0.02)
    spawnAtPosition(fireStarter.pos, 0.1)
    PointLight(fireStarter.pos, 1, 0.3, 0.1, 0.2)
end
