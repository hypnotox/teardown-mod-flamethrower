ParticleManager = {}

function ParticleManager:spawnNozzleFlameParticles()
    ParticleReset()
    local fireStarter = Flamethrower:getFireStarterTransform()
    local direction

    if InputDown('usetool') then
        direction = TransformToParentVec(fireStarter, Vec(-0.3, 0.7, 0))
        ParticleGravity(0, -10)
    else
        direction = TransformToParentVec(fireStarter, Vec(0, 0.7, 0))
        ParticleGravity(5, 10)
    end

    local flameVelocityHigh = VecAdd(direction, VecScale(direction, 0.2))
    local flameVelocityLow = VecAdd(direction, VecScale(direction, 0.05))

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
    SpawnParticle(fireStarter.pos, flameVelocityHigh, 0.1)
    SpawnParticle(fireStarter.pos, flameVelocityLow, 0.15)

    -- orange tint
    ParticleColor(1, math.random(28, 44) / 100, 0)
    ParticleRadius(0.06, 0.02)
    SpawnParticle(fireStarter.pos, flameVelocityHigh, 0.1)
    SpawnParticle(fireStarter.pos, flameVelocityLow, 0.15)
    PointLight(fireStarter.pos, 1, 0.3, 0.1, 0.2)
end

function ParticleManager:spawnFlameParticles(flameVelocity, lifetime)
    local nozzle = Flamethrower:getNozzleTransform()
    local flameVelocity30 = VecAdd(flameVelocity, VecScale(direction, 30))
    local flameVelocity20 = VecAdd(flameVelocity, VecScale(direction, 20))

    ParticleReset()
    ParticleSticky(0.1)
    ParticleCollide(0.1)
    ParticleGravity(5, -10)
    ParticleDrag(0, 0.5)
    ParticleStretch(10)
    ParticleTile(5)

    -- white core
    ParticleColor(1, math.random(9, 10) / 10, math.random(9, 10) / 10)
    ParticleEmissive(2, 0)
    ParticleRadius(0.02, 0.7)
    ParticleAlpha(0.5, 0)
    SpawnParticle(nozzle.pos, flameVelocity30, lifetime)
    SpawnParticle(nozzle.pos, flameVelocity20, lifetime * 0.8)

    -- orange tint
    ParticleColor(1, math.random(28, 44) / 100, 0)
    ParticleEmissive(6, 0)
    ParticleRadius(0.03, 1.2)
    ParticleAlpha(1, 0)
    SpawnParticle(nozzle.pos, flameVelocity30, lifetime)
    SpawnParticle(nozzle.pos, flameVelocity20, lifetime * 0.8)

    -- red splatter
    ParticleColor(1, math.random(5, 15) / 100, 0)
    ParticleEmissive(4, 0)
    ParticleRadius(0.03, 1.3)
    ParticleAlpha(0.2, 0)
    SpawnParticle(nozzle.pos, flameVelocity30, lifetime)
    SpawnParticle(nozzle.pos, flameVelocity20, lifetime * 0.8)

    -- red cloud
    ParticleColor(1, math.random(40, 50) * 0.01, 0, 1, math.random(20, 40) * 0.01, 0)
    ParticleEmissive(3, 0)
    ParticleRadius(0.03, 1.5)
    ParticleAlpha(0.8, 0)
    SpawnParticle(nozzle.pos, flameVelocity30, lifetime)
    SpawnParticle(nozzle.pos, flameVelocity20, lifetime * 0.8)
end
