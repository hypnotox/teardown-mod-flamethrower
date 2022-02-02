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

function playSoundsIfNecessary()
    -- Ignition and Extinguish sound effects for the Flamethrower
    if GetString("game.player.tool") == "hypnotox_flamethrower" and InputPressed("lmb") then
        PlaySound(soundFlamethrowerStart, GetPlayerTransform().pos, soundVolume)
        PlaySound(soundFlamethrowerActive, GetPlayerTransform().pos, soundVolume)
    end
    if GetString("game.player.tool") == "hypnotox_flamethrower" and InputReleased("lmb") then
        PlaySound(soundFlamethrowerEnd, GetPlayerTransform().pos, soundVolume)
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
        local fwd = TransformToParentVec(camera, Vec(0, 0, -1))
        local hit, dist, normal, shape = QueryRaycast(camera.pos, fwd, maxFlameDist)
        local hitPoint = Transform(VecAdd(camera.pos, VecScale(fwd, dist)), camera.rot)

        if flameCooldown <= 0 then
            table.insert(flames, {
                ['transform'] = TransformCopy(camera),
                ['distance'] = 0
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

        if flame['distance'] > maxFlameDist then
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
    local nozzle = TransformToParentTransform(camera, Transform(Vec(0.3, -0.3, -1.2)))
    local d = TransformToParentVec(camera, Vec(-0.07, 0.06, -1))

    if InputDown("lmb") then -- Flamethrower Flame Effects
        local playerVelocity = GetPlayerVelocity()
        playerVelocity = VecAdd(playerVelocity, VecScale(d, -0.1))
        local pvel = VecScale(playerVelocity, .7)

        ParticleReset()
        ParticleSticky(0.1)
        ParticleCollide(0.01)
        ParticleTile(5)
        ParticleGravity(0, 20)
        ParticleDrag(0, 0.3)

        -- medium orange to red
        ParticleColor(1, math.random(40, 50) * 0.01, 0, 1, math.random(20, 40) * 0.01, 0)
        ParticleEmissive(1, 0)
        ParticleRadius(0.06, 2)
        ParticleAlpha(1, 0)
        SpawnParticle(nozzle.pos, VecAdd(pvel, VecScale(d, 30)), 0.7) -- medium orange to red

        -- smaller yellow to orange
        ParticleColor(1, math.random(75, 85) * .01, .1, 1, math.random(55, 65) * 0.01, 0.4)
        ParticleEmissive(3, 0)
        ParticleRadius(0.05, 1.5)
        ParticleAlpha(1, 0)
        SpawnParticle(nozzle.pos, VecAdd(pvel, VecScale(d, 30)), 0.7) -- smaller yellow to orange

        -- smallest white to white/yellow
        ParticleColor(1, 1, 0.8, 0.8, 0.8, math.random(50, 60) * 0.01)
        ParticleEmissive(5, 0)
        ParticleTile(3)
        ParticleRadius(0.1, 1.25)
        ParticleAlpha(0.5, 0, "easeout")
        SpawnParticle(nozzle.pos, VecAdd(pvel, VecScale(d, 30)), 0.7) -- smallest white to white/yellow

        -- bigger black
        ParticleRadius(0.1, 5)
        ParticleEmissive(0, 0)
        ParticleColor(0, 0, 0, 0.1, 0.1, 0.1)
        ParticleTile(14)
        ParticleAlpha(0.6, 0)
        SpawnParticle(nozzle.pos, VecAdd(pvel, VecScale(d, 30)), 1.8) -- bigger black

        -- Play Flamethrower sound
        PlayLoop(soundFlamethrowerActive, GetPlayerTransform().pos, soundVolume)
    end
end
