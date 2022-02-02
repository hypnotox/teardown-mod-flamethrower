Flamethrower = {
    maxFlameDist = 15,
    flameVelocity = 20,
    flames = {},
    soundVolume = 1
}

function Flamethrower.init()
    RegisterTool("hypnotox_flamethrower", "Flamethrower", "MOD/vox/Flamethrower.vox")
    SetBool("game.tool.hypnotox_flamethrower.enabled", true)
    SetInt("game.tool.hypnotox_flamethrower.ammo", 100)
    soundFlamethrowerActive = LoadLoop("sound/flamethrower-active.ogg")
    soundFlamethrowerStart = LoadSound("sound/flamethrower-start.ogg")
    soundFlamethrowerEnd = LoadSound("sound/flamethrower-end.ogg")
end

function Flamethrower.tick(dt)
    SetBool("hud.aimdot", false)
    Flamethrower.playSoundsIfNecessary()
    Flamethrower.setToolPosition()
    Flamethrower.emulateFlames(dt)
    Flamethrower.spawnParticles()
end

function Flamethrower.randomPoint(offsetFrom, radius)
    local radius = radius * 100
    local offsetLength = math.random(-radius, radius) / 100
    local offsetRotation = QuatEuler(math.random(0, 360), math.random(0, 360), math.random(0, 360))

    return VecAdd(offsetFrom, QuatRotateVec(offsetRotation, Vec(0, 0, offsetLength)))
end

function Flamethrower.setToolPosition()
    if InputDown("lmb") then
        local offset = Transform(Vec(0.3, -0.3, -.71))
        SetToolTransform(offset, 0.3)
    else
        local offset = Transform(Vec(0.3, -0.3, -.74))
        SetToolTransform(offset, 0.6)
    end
end

function Flamethrower.playSoundsIfNecessary()
    if InputPressed("lmb") then
        PlaySound(soundFlamethrowerStart, GetPlayerTransform().pos, Flamethrower.soundVolume)
        PlaySound(soundFlamethrowerActive, GetPlayerTransform().pos, Flamethrower.soundVolume)
    end

    if InputReleased("lmb") then
        PlaySound(soundFlamethrowerEnd, GetPlayerTransform().pos, Flamethrower.soundVolume)
    end

    if InputDown("lmb") then
        PlayLoop(soundFlamethrowerActive, GetPlayerTransform().pos, Flamethrower.soundVolume)
    end
end

function Flamethrower.emulateFlames(dt)
    if InputDown("lmb") then
        local offset = Transform(Vec(0.3, -0.3, -.71))
        SetToolTransform(offset, 0.3)

        local camera = GetCameraTransform()
        local nozzle = TransformToParentTransform(camera, Transform(Vec(0.3, -0.3, -1.3)))
        local fwd = TransformToParentVec(nozzle, Vec(0, 0, -1))
        local hit, dist, normal, shape = QueryRaycast(nozzle.pos, fwd, Flamethrower.maxFlameDist)
        local hitPoint = Transform(VecAdd(nozzle.pos, VecScale(fwd, dist)), nozzle.rot)

        table.insert(Flamethrower.flames, {
            ['transform'] = TransformCopy(nozzle),
            ['distance'] = 0,
            ['maxDistance'] = dist
        })
    else
        local offset = Transform(Vec(0.3, -0.3, -.74))
        SetToolTransform(offset, 0.6)
    end

    local distance = Flamethrower.flameVelocity * dt

    for i, flame in ipairs(Flamethrower.flames) do
        local size = flame['distance'] / 8
        local currentTransform = TransformToParentTransform(flame['transform'], Transform(Vec(0, 0, -distance)))
        PointLight(currentTransform.pos, 1, 0.7, 0.3, size)

        for j = 1, 10, 1 do
            local point = Flamethrower.randomPoint(currentTransform.pos, size)
            SpawnFire(point)
        end

        flame['transform'] = currentTransform
        flame['distance'] = flame['distance'] + distance

        if flame['distance'] > flame['maxDistance'] then
            table.remove(Flamethrower.flames, i)
        end
    end
end

function Flamethrower.spawnParticles()
    local camera = GetCameraTransform()
    local nozzle = TransformToParentTransform(camera, Transform(Vec(0.3, -0.3, -1.3)))
    local direction = TransformToParentVec(nozzle, Vec(0, 0, -1))

    if InputDown("lmb") then
        local playerVelocity = GetPlayerVelocity()
        playerVelocity = VecAdd(playerVelocity, VecScale(direction, -0.1))
        local flameVelocity = VecScale(playerVelocity, .7)

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
        ParticleRadius(0.04, 1, 'easeout')
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
