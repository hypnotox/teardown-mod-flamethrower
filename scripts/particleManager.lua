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

    self.nozzleFlameVelocityHigh = VecAdd(direction, VecScale(direction, 0.2))
    self.nozzleFlameVelocityLow = VecAdd(direction, VecScale(direction, 0.05))

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
    self:spawnNozzleFlameParticle(fireStarter.pos, 0.1)

    -- orange tint
    ParticleColor(1, math.random(28, 44) / 100, 0)
    ParticleRadius(0.06, 0.02)
    self:spawnNozzleFlameParticle(fireStarter.pos, 0.1)
    PointLight(fireStarter.pos, 1, 0.3, 0.1, 0.2)
end

function ParticleManager:spawnNozzleFlameParticle(pos, lifetime)
    SpawnParticle(pos, self.nozzleFlameVelocityHigh, lifetime)
    SpawnParticle(pos, self.nozzleFlameVelocityLow, lifetime * 1.7)
end

function ParticleManager:spawnFlameParticles(flameVelocity, lifetime)
    local nozzle = Flamethrower:getNozzleTransform()
    self.flameVelocityHigh = VecAdd(flameVelocity, VecScale(direction, 30))
    self.flameVelocityMedium = VecAdd(flameVelocity, VecScale(direction, 25))
    self.flameVelocityLow = VecAdd(flameVelocity, VecScale(direction, 20))

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
    self:spawnFlameParticle(nozzle.pos, lifetime)

    -- orange tint
    ParticleColor(1, math.random(28, 44) / 100, 0)
    ParticleEmissive(6, 0)
    ParticleRadius(0.03, 1.2)
    ParticleAlpha(1, 0)
    self:spawnFlameParticle(nozzle.pos, lifetime)

    -- red splatter
    ParticleColor(1, math.random(5, 15) / 100, 0)
    ParticleEmissive(4, 0)
    ParticleRadius(0.03, 1.3)
    ParticleAlpha(0.2, 0)
    self:spawnFlameParticle(nozzle.pos, lifetime)

    -- red cloud
    ParticleColor(1, math.random(40, 50) * 0.01, 0, 1, math.random(20, 40) * 0.01, 0)
    ParticleEmissive(3, 0)
    ParticleRadius(0.03, 1.5)
    ParticleAlpha(0.8, 0)
    self:spawnFlameParticle(nozzle.pos, lifetime)
end

function ParticleManager:spawnFlameParticle(pos, lifetime)
    SpawnParticle(pos, self.flameVelocityHigh, lifetime)
    SpawnParticle(pos, self.flameVelocityMedium, lifetime * 0.7)
    SpawnParticle(pos, self.flameVelocityLow, lifetime * 0.4)
end
