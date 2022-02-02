local maxFlameDist = 15
local baseFlameCooldown = 0.2
local flameCooldown = 0
local flameVelocity = 20
local flames = {}
local soundVolume = 1

function init()
    RegisterTool("hypnotox_flamethrower", "Flamethrower", "MOD/vox/Flamethrower.vox")
    SetBool("game.tool.hypnotox_flamethrower.enabled", true)
    SetInt("game.tool.hypnotox_flamethrower.ammo", 100)
    soundFlamethrowerActive = LoadLoop("sound/flamethrower-active.ogg")
    soundFlamethrowerStart = LoadSound("sound/flamethrower-start.ogg")
    soundFlamethrowerEnd = LoadSound("sound/flamethrower-end.ogg")
end

function tick(dt)
    if GetString("game.player.tool") == "hypnotox_flamethrower" and GetBool("game.player.canusetool") then
        SetBool("hud.aimdot", false)
        playSoundsIfNecessary()
        setToolPosition()
        emulateFlames(dt)
        spawnParticles()
    end
end

function randomPoint(offsetFrom, radius)
    local radius = radius * 100
    local offsetLength = math.random(-radius, radius) / 100
    local offsetRotation = QuatEuler(math.random(0, 360), math.random(0, 360), math.random(0, 360))

    return VecAdd(offsetFrom, QuatRotateVec(offsetRotation, Vec(0, 0, offsetLength)))
end

function setToolPosition()
    if InputDown("lmb") then
        -- Minimum Tool Recoil
        local offset = Transform(Vec(0.3, -0.3, -.71))
        SetToolTransform(offset, 0.3)
    else
        -- Resting Tool Position
        local offset = Transform(Vec(0.3, -0.3, -.74))
        SetToolTransform(offset, 0.6)
    end
end

function playSoundsIfNecessary()
    -- Ignition and Extinguish sound effects for the Flamethrower
    if InputPressed("lmb") then
        PlaySound(soundFlamethrowerStart, GetPlayerTransform().pos, soundVolume)
        PlaySound(soundFlamethrowerActive, GetPlayerTransform().pos, soundVolume)
    end

    if InputReleased("lmb") then
        PlaySound(soundFlamethrowerEnd, GetPlayerTransform().pos, soundVolume)
    end

    if InputDown("lmb") then
        PlayLoop(soundFlamethrowerActive, GetPlayerTransform().pos, soundVolume)
    end
end

function emulateFlames(dt)
    if InputReleased("lmb") then
        flameCooldown = 0
    end

    if InputDown("lmb") then
        -- Minimum Tool Recoil
        local offset = Transform(Vec(0.3, -0.3, -.71))
        SetToolTransform(offset, 0.3)

        -- Get fire spawn locations in front of Player
        local camera = GetCameraTransform()
        local nozzle = TransformToParentTransform(camera, Transform(Vec(0.3, -0.3, -1.3)))
        local fwd = TransformToParentVec(nozzle, Vec(0, 0, -1))
        local hit, dist, normal, shape = QueryRaycast(nozzle.pos, fwd, maxFlameDist)
        local hitPoint = Transform(VecAdd(nozzle.pos, VecScale(fwd, dist)), nozzle.rot)

        if flameCooldown <= 0 then
            table.insert(flames, {
                ['transform'] = TransformCopy(nozzle),
                ['distance'] = 0,
                ['maxDistance'] = dist
            })
        end
    else
        -- Resting Tool Position
        local offset = Transform(Vec(0.3, -0.3, -.74))
        SetToolTransform(offset, 0.6)
    end

    local distance = flameVelocity * dt

    for i, flame in ipairs(flames) do
        local size = flame['distance'] / 8
        local currentTransform = TransformToParentTransform(flame['transform'], Transform(Vec(0, 0, -distance)))
        PointLight(currentTransform.pos, 1, 0.7, 0.3, size)

        for j = 1, 10, 1 do
            local point = randomPoint(currentTransform.pos, size)
            SpawnFire(point)
        end

        flame['transform'] = currentTransform
        flame['distance'] = flame['distance'] + distance

        if flame['distance'] > flame['maxDistance'] then
            table.remove(flames, i)
        end
    end

    if flameCooldown > 0 then
        flameCooldown = flameCooldown - dt
    end
end

function spawnParticles(dt)
    -- Compute hit points and front direction of Player Weapon in world space
    local camera = GetCameraTransform()
    local nozzle = TransformToParentTransform(camera, Transform(Vec(0.3, -0.3, -1.3)))
    local direction = TransformToParentVec(nozzle, Vec(0, 0, -1))

    if InputDown("lmb") then -- Flamethrower Flame Effects
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
