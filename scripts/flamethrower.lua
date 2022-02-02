#include "flame.lua"

Flamethrower = {
    maxFlameDist = 15,
    flameVelocity = 20,
    flames = {},
    soundVolume = 1,
    nozzleOffset = Vec(0.3, -0.3, -1.1)
}

function Flamethrower:init()
    RegisterTool("hypnotox_flamethrower", "Flamethrower", "MOD/vox/Flamethrower.vox")
    SetBool("game.tool.hypnotox_flamethrower.enabled", true)
    SetInt("game.tool.hypnotox_flamethrower.ammo", 100)
    self.soundFlamethrowerActive = LoadLoop("sound/flamethrower-active.ogg")
    self.soundFlamethrowerStart = LoadSound("sound/flamethrower-start.ogg")
    self.soundFlamethrowerEnd = LoadSound("sound/flamethrower-end.ogg")
end

function Flamethrower:tick(dt)
    SetBool("hud.aimdot", false)
    self:playSoundsIfNecessary()
    self:setToolPosition()
    self:spawnNozzleFlameParticles()
    self:spawnFlameParticles()
    self:emulateFlames(dt)
end

function Flamethrower:setToolPosition()
    if InputDown("lmb") then
        local offset = Transform(Vec(0.3, -0.3, -.71))
        SetToolTransform(offset, 0.3)
    else
        local offset = Transform(Vec(0.3, -0.3, -.74))
        SetToolTransform(offset, 0.6)
    end
end

function Flamethrower:playSoundsIfNecessary()
    if InputPressed("lmb") then
        PlaySound(self.soundFlamethrowerStart, GetPlayerTransform().pos, Flamethrower.soundVolume)
        PlaySound(self.soundFlamethrowerActive, GetPlayerTransform().pos, Flamethrower.soundVolume)
    end

    if InputReleased("lmb") then
        PlaySound(self.soundFlamethrowerEnd, GetPlayerTransform().pos, Flamethrower.soundVolume)
    end

    if InputDown("lmb") then
        PlayLoop(self.soundFlamethrowerActive, GetPlayerTransform().pos, Flamethrower.soundVolume)
    end
end

function Flamethrower:emulateFlames(dt)
    if InputDown("lmb") then
        local offset = Transform(Vec(0.3, -0.3, -.71))
        SetToolTransform(offset, 0.3)

        local camera = GetCameraTransform()
        local nozzle = TransformToParentTransform(camera, Transform(self.nozzleOffset))
        local fwd = TransformToParentVec(nozzle, Vec(0, 0, -1))
        local hit, dist, normal, shape = QueryRaycast(nozzle.pos, fwd, self.maxFlameDist)
        local hitPoint = Transform(VecAdd(nozzle.pos, VecScale(fwd, dist)), nozzle.rot)

        table.insert(self.flames, Flame:new(nozzle, dist))
    else
        local offset = Transform(Vec(0.3, -0.3, -.74))
        SetToolTransform(offset, 0.6)
    end

    local distance = self.flameVelocity * dt

    for i, flame in ipairs(self.flames) do
        flame:tick(dt, distance)

        if flame.distance > flame.maxDistance then
            table.remove(self.flames, i)
        end
    end
end

function Flamethrower:spawnNozzleFlameParticles()
    local camera = GetCameraTransform()
    local nozzle = TransformToParentTransform(camera, Transform(VecAdd(self.nozzleOffset, Vec(0, -0.05, 0))))
    local direction = TransformToParentVec(nozzle, Vec(0, 1, -1))

    local playerVelocity = GetPlayerVelocity()
    local flameVelocity = VecAdd(playerVelocity, VecScale(direction, 0.01))

    local flameVelocityHigh = VecAdd(flameVelocity, VecScale(direction, 0.1))
    local flameVelocityMedium = VecAdd(flameVelocity, VecScale(direction, 0.05))
    local flameVelocityLow = VecAdd(flameVelocity, VecScale(direction, 0.025))

    ParticleReset()
    ParticleSticky(0)
    ParticleCollide(0)
    ParticleGravity(0, 10)
    ParticleDrag(0)
    ParticleTile(5)

    -- white core
    ParticleColor(1, math.random(9, 10) / 10, math.random(9, 10) / 10)
    ParticleEmissive(1, 0)
    ParticleRadius(0.03, 0.01)
    ParticleAlpha(0.7, 0)
    SpawnParticle(nozzle.pos, flameVelocityHigh, 0.1)
    SpawnParticle(nozzle.pos, flameVelocityMedium, 0.15)
    SpawnParticle(nozzle.pos, flameVelocityLow, 0.18)

    -- orange tint
    ParticleColor(1, math.random(28, 44) / 100, 0)
    ParticleEmissive(1, 0)
    ParticleRadius(0.05, 0.02)
    ParticleAlpha(0.7, 0)
    SpawnParticle(nozzle.pos, flameVelocityHigh, 0.1)
    SpawnParticle(nozzle.pos, flameVelocityMedium, 0.15)
    SpawnParticle(nozzle.pos, flameVelocityLow, 0.18)
end

function Flamethrower:spawnFlameParticles()
    local camera = GetCameraTransform()
    local nozzle = TransformToParentTransform(camera, Transform(self.nozzleOffset))
    local direction = TransformToParentVec(nozzle, Vec(0, 0, -1))

    if InputDown("lmb") then
        local playerVelocity = GetPlayerVelocity()
        local flameVelocity = VecScale(VecAdd(playerVelocity, VecScale(direction, -0.1)), 0.7)

        local flameVelocity30 = VecAdd(flameVelocity, VecScale(direction, 30))
        local flameVelocity25 = VecAdd(flameVelocity, VecScale(direction, 25))
        local flameVelocity20 = VecAdd(flameVelocity, VecScale(direction, 20))

        ParticleReset()
        ParticleSticky(0.1)
        ParticleCollide(0.1)
        ParticleGravity(0, 20)
        ParticleDrag(0, 0.5)
        ParticleStretch(10)
        ParticleTile(5)

        -- white core
        ParticleColor(1, math.random(9, 10) / 10, math.random(9, 10) / 10)
        ParticleEmissive(1, 0)
        ParticleRadius(0.02, 0.6, 'easeout')
        ParticleAlpha(0.5, 0)
        SpawnParticle(nozzle.pos, flameVelocity30, 0.7)
        SpawnParticle(nozzle.pos, flameVelocity25, 0.6)
        SpawnParticle(nozzle.pos, flameVelocity20, 0.5)

        -- orange tint
        ParticleColor(1, math.random(28, 44) / 100, 0)
        ParticleEmissive(5, 0)
        ParticleRadius(0.03, 0.8, 'easeout')
        ParticleAlpha(1, 0)
        SpawnParticle(nozzle.pos, flameVelocity30, 0.7)
        SpawnParticle(nozzle.pos, flameVelocity25, 0.6)
        SpawnParticle(nozzle.pos, flameVelocity20, 0.5)

        -- red splatter
        ParticleColor(1, math.random(5, 15) / 100, 0)
        ParticleEmissive(3, 0)
        ParticleRadius(0.03, 1, 'easeout')
        ParticleAlpha(0.2, 0)
        SpawnParticle(nozzle.pos, flameVelocity30, 0.7)
        SpawnParticle(nozzle.pos, flameVelocity25, 0.6)
        SpawnParticle(nozzle.pos, flameVelocity20, 0.5)

        -- red cloud
        ParticleColor(1, math.random(40, 50) * 0.01, 0, 1, math.random(20, 40) * 0.01, 0)
        ParticleEmissive(1, 0)
        ParticleRadius(0.03, 1.2, 'easeout')
        ParticleAlpha(0.8, 0)
        SpawnParticle(nozzle.pos, flameVelocity30, 0.7)
        SpawnParticle(nozzle.pos, flameVelocity25, 0.6)
        SpawnParticle(nozzle.pos, flameVelocity20, 0.5)
    end
end
