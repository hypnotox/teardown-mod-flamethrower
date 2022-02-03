ParticleManager = {}

function ParticleManager:spawnNozzleFlameParticles()
    local camera = GetCameraTransform()
    local nozzle = TransformToParentTransform(camera, Transform(VecAdd(Flamethrower.nozzleOffset, Vec(0, -0.05, 0))))
    local direction = TransformToParentVec(nozzle, Vec(0, 1, -1))
    local flameVelocity = VecScale(direction, 0.01)

    local flameVelocityHigh = VecAdd(flameVelocity, VecScale(direction, 0.1))
    local flameVelocityMedium = VecAdd(flameVelocity, VecScale(direction, 0.05))
    local flameVelocityLow = VecAdd(flameVelocity, VecScale(direction, 0.025))

    ParticleReset()
    ParticleSticky(0)
    ParticleCollide(0)
    ParticleGravity(5, -10)
    ParticleDrag(0)
    ParticleTile(5)

    -- white core
    ParticleColor(1, math.random(9, 10) / 10, math.random(9, 10) / 10)
    ParticleEmissive(1, 0)
    ParticleRadius(0.04, 0.015)
    ParticleAlpha(0.7, 0)
    SpawnParticle(nozzle.pos, flameVelocityHigh, 0.15)
    SpawnParticle(nozzle.pos, flameVelocityMedium, 0.2)
    SpawnParticle(nozzle.pos, flameVelocityLow, 0.25)

    -- orange tint
    ParticleColor(1, math.random(28, 44) / 100, 0)
    ParticleEmissive(1, 0)
    ParticleRadius(0.06, 0.015)
    ParticleAlpha(0.7, 0)
    SpawnParticle(nozzle.pos, flameVelocityHigh, 0.15)
    SpawnParticle(nozzle.pos, flameVelocityMedium, 0.2)
    SpawnParticle(nozzle.pos, flameVelocityLow, 0.25)
    PointLight(nozzle.pos, 1, 0.3, 0.1, 0.2)
end

function ParticleManager:spawnFlameParticles()
    if InputDown('usetool') then
        local camera = GetCameraTransform()
        local nozzle = TransformToParentTransform(camera, Transform(Flamethrower.nozzleOffset))
        local direction = TransformToParentVec(nozzle, Vec(0, 0, -1))
        local flameVelocity = VecScale(VecScale(direction, -0.1), 0.7)

        local flameVelocity30 = VecAdd(flameVelocity, VecScale(direction, 30))
        local flameVelocity25 = VecAdd(flameVelocity, VecScale(direction, 25))
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
        ParticleRadius(0.02, 0.6)
        ParticleAlpha(0.5, 0)
        SpawnParticle(nozzle.pos, flameVelocity30, 0.7)
        SpawnParticle(nozzle.pos, flameVelocity25, 0.6)
        SpawnParticle(nozzle.pos, flameVelocity20, 0.5)

        -- orange tint
        ParticleColor(1, math.random(28, 44) / 100, 0)
        ParticleEmissive(6, 0)
        ParticleRadius(0.03, 0.8)
        ParticleAlpha(1, 0)
        SpawnParticle(nozzle.pos, flameVelocity30, 0.7)
        SpawnParticle(nozzle.pos, flameVelocity25, 0.6)
        SpawnParticle(nozzle.pos, flameVelocity20, 0.5)

        -- red splatter
        ParticleColor(1, math.random(5, 15) / 100, 0)
        ParticleEmissive(4, 0)
        ParticleRadius(0.03, 1)
        ParticleAlpha(0.2, 0)
        SpawnParticle(nozzle.pos, flameVelocity30, 0.7)
        SpawnParticle(nozzle.pos, flameVelocity25, 0.6)
        SpawnParticle(nozzle.pos, flameVelocity20, 0.5)

        -- red cloud
        ParticleColor(1, math.random(40, 50) * 0.01, 0, 1, math.random(20, 40) * 0.01, 0)
        ParticleEmissive(3, 0)
        ParticleRadius(0.03, 1.2)
        ParticleAlpha(0.8, 0)
        SpawnParticle(nozzle.pos, flameVelocity30, 0.7)
        SpawnParticle(nozzle.pos, flameVelocity25, 0.6)
        SpawnParticle(nozzle.pos, flameVelocity20, 0.5)
    end
end
