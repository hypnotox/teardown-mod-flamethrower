-- Nozzle (presentation): derives the nozzle world transform from the tool body
-- (a client-side visual), builds the firing parameters handed to Simulation, and
-- renders the flame-jet particles. No world mutation here.
Nozzle = {}

local function spawnAtPosition(pos, lifetime, flameVelocity)
    SpawnParticle(pos, flameVelocity, lifetime)
    SpawnParticle(pos, flameVelocity, lifetime * 0.8)
    SpawnParticle(pos, flameVelocity, lifetime * 0.7)
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
        TransformToParentTransform(
            Transform(transform.pos, toolTransform.rot),
            Engine:voxelCenterOffset()
        ),
        Transform(Vec(0, 0, -0.05))
    )
end

-- Build the firing parameters that cross the seam to Simulation:fire (the future
-- ServerCall payload). Only transform + speed + lifetime are needed server-side;
-- the particle velocity vector is derived locally for FX.
function Nozzle:buildFiringParams()
    return {
        transform = self:getNozzleTransform(),
        speed = State:getFlameVelocity() * 2,
        lifetime = 1.3,
    }
end

-- Render the flame jet for a shot. Pure local FX.
function Nozzle:spawnJetParticles(params)
    local nozzle = params.transform
    local direction = TransformToParentVec(nozzle, Vec(0, 0, -1))
    local flameVelocity = VecScale(direction, params.speed)
    local lifetime = params.lifetime
    local startSize = 0.03
    local endSize = 0.8

    ParticleReset()
    ParticleSticky(0.1, 1, 'easein')
    ParticleCollide(0, 0.001, 'easein')
    ParticleGravity(5, -10)
    ParticleDrag(0)
    ParticleStretch(5)
    ParticleTile(5)

    -- white core
    ParticleColor(1, math.random(9, 10) / 10, math.random(9, 10) / 10)
    ParticleEmissive(2, 0)
    ParticleRadius(startSize, endSize)
    ParticleAlpha(0.8, 0.5)
    spawnAtPosition(nozzle.pos, lifetime, flameVelocity)

    -- orange tint
    ParticleColor(1, math.random(28, 44) / 100, 0)
    ParticleEmissive(6, 3)
    ParticleRadius(startSize * 1.5, endSize * 1.5)
    ParticleAlpha(0.8, 0.5)
    spawnAtPosition(nozzle.pos, lifetime, flameVelocity)

    -- red splatter
    ParticleColor(1, math.random(5, 15) / 100, 0)
    ParticleEmissive(4, 2)
    ParticleRadius(startSize * 1.5, endSize * 1.7)
    ParticleAlpha(0.3, 0.7)
    spawnAtPosition(nozzle.pos, lifetime, flameVelocity)

    -- red cloud
    ParticleColor(1, math.random(40, 50) * 0.01, 0, 1, math.random(20, 40) * 0.01, 0)
    ParticleEmissive(3, 1)
    ParticleRadius(startSize * 1.5, endSize * 2.5)
    ParticleAlpha(0.8, 0.5)
    spawnAtPosition(nozzle.pos, lifetime, flameVelocity)
end
