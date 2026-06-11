-- Nozzle (presentation): derives the nozzle world transform from the tool body
-- (a client-side visual), builds the firing parameters handed to Simulation, and
-- renders the flame-jet particles. No world mutation here.
Nozzle = {}

-- Emit a layer's three particles, each with a cone-jittered velocity in the
-- nozzle's local frame, then transformed to world. The cone widens per layer
-- (tight core -> wide cloud), producing the velocity-divergence trumpet bloom.
local function spawnJet(transform, pos, speed, lifetime, coneDeg)
    for _, lt in ipairs({lifetime, lifetime * 0.8, lifetime * 0.7}) do
        local localDir = QuatRotateVec(
            QuatEuler(math.random(-coneDeg, coneDeg), math.random(-coneDeg, coneDeg), 0),
            Vec(0, 0, -1)
        )
        local vel = VecScale(TransformToParentVec(transform, localDir), speed)
        SpawnParticle(pos, vel, lt)
    end
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
    local transform = params.transform
    local pos = transform.pos
    local speed = params.speed
    local lifetime = params.lifetime
    local startSize = 0.03
    local endSize = 0.8

    ParticleReset()
    ParticleSticky(0.1, 1, 'easein')
    ParticleCollide(0, 0.001, 'easein')
    ParticleDrag(0.05)
    ParticleStretch(5)
    ParticleTile(5)

    -- white core (tight cone, droops with the flames)
    ParticleGravity(-2, -8)
    ParticleColor(1, math.random(9, 10) / 10, math.random(9, 10) / 10)
    ParticleEmissive(2, 0)
    ParticleRadius(startSize, endSize)
    ParticleAlpha(0.8, 0.5)
    spawnJet(transform, pos, speed, lifetime, 1)

    -- orange tint (droops)
    ParticleGravity(-2, -8)
    ParticleColor(1, math.random(28, 44) / 100, 0)
    ParticleEmissive(6, 3)
    ParticleRadius(startSize * 1.5, endSize * 1.5)
    ParticleAlpha(0.8, 0.5)
    spawnJet(transform, pos, speed, lifetime, 2)

    -- red splatter (droops, wider cone)
    ParticleGravity(-2, -8)
    ParticleColor(1, math.random(5, 15) / 100, 0)
    ParticleEmissive(4, 2)
    ParticleRadius(startSize * 1.5, endSize * 1.7)
    ParticleAlpha(0.3, 0.7)
    spawnJet(transform, pos, speed, lifetime, 3)

    -- red cloud (rising smoke, widest cone)
    ParticleGravity(4, -2)
    ParticleColor(1, math.random(40, 50) * 0.01, 0, 1, math.random(20, 40) * 0.01, 0)
    ParticleEmissive(3, 1)
    ParticleRadius(startSize * 1.5, endSize * 2.5)
    ParticleAlpha(0.8, 0.5)
    spawnJet(transform, pos, speed, lifetime, 5)
end
