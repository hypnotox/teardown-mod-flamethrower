local maxDist = 15
local waftCooldown = 0.2
local currentWaftCooldown = 0
local waftVelocity = 20
local wafts = {}

function init()
    RegisterTool("hypnotox_flamethrower", "Flamethrower", "MOD/vox/Flamethrower.vox")
    SetBool("game.tool.hypnotox_flamethrower.enabled", true)
    SetInt("game.tool.hypnotox_flamethrower.ammo", 100)
    soundIncinerate = LoadLoop("sound/incinerate.ogg")
    soundIgnition = LoadSound("sound/ignition.ogg")
    soundExtinguish = LoadSound("sound/extinguish.ogg")
end

function tick(dt)
    if GetString("game.player.tool") == "hypnotox_flamethrower" and GetBool("game.player.canusetool") then
        SetBool("hud.aimdot", false)

        -- Ignition and Extinguish sound effects for the Flamethrower
        if GetString("game.player.tool") == "hypnotox_flamethrower" and InputPressed("lmb") then
            PlaySound(soundIgnition, GetPlayerTransform().pos, (math.random(50, 60) * 0.01))
        end
        if GetString("game.player.tool") == "hypnotox_flamethrower" and InputReleased("lmb") then
            PlaySound(soundExtinguish, GetPlayerTransform().pos, (math.random(10, 20) * 0.01))
        end

        if InputReleased("lmb") then
            currentWaftCooldown = 0
        end

        if InputDown("lmb") then
            -- Minimum Tool Recoil
            local offset = Transform(Vec(0.3, -0.3, -.71))
            SetToolTransform(offset, 0.3)

            -- Get fire spawn locations in front of Player
            local camera = GetCameraTransform()
            local fwd = TransformToParentVec(camera, Vec(0, 0, -1))
            local hit, dist, normal, shape = QueryRaycast(camera.pos, fwd, maxDist)
            local hitPoint = Transform(VecAdd(camera.pos, VecScale(fwd, dist)), camera.rot)

            if currentWaftCooldown <= 0 then
                table.insert(wafts, {
                    ['transform'] = TransformCopy(camera),
                    ['distance'] = 0
                })
            end
        else
            -- Resting Tool Position
            local offset = Transform(Vec(0.3, -0.3, -.74))
            SetToolTransform(offset, 0.6)
        end

        local distance = waftVelocity * dt

        for i, waft in ipairs(wafts) do
            local size = waft['distance'] / 8
            local currentTransform = TransformToParentTransform(waft['transform'], Transform(Vec(0, 0, -distance)))
            PointLight(currentTransform.pos, 1, 0.7, 0.3, size)

            for j = 1, 20, 1 do
                local point = randomPoint(currentTransform.pos, size)
                SpawnFire(point)
            end

            waft['transform'] = currentTransform
            waft['distance'] = waft['distance'] + distance

            if waft['distance'] > maxDist then
                table.remove(wafts, i)
            end
        end

        if currentWaftCooldown > 0 then
            currentWaftCooldown = currentWaftCooldown - dt
        end
    end
end

function randomPoint(offsetFrom, radius)
    local radius = radius * 100
    local offsetLength = math.random(-radius, radius) / 100
    local offsetRotation = QuatEuler(math.random(0, 360), math.random(0, 360), math.random(0, 360))

    return VecAdd(offsetFrom, QuatRotateVec(offsetRotation, Vec(0, 0, offsetLength)))
end

function update(dt)
    if GetString("game.player.tool") == "hypnotox_flamethrower" and GetBool("game.player.canusetool") then
        -- Compute hit points and front direction of Player Weapon in world space
        local camera = GetCameraTransform()
        local nozzle = TransformToParentTransform(camera, Transform(Vec(0.3, -0.3, -1.2)))
        local d = TransformToParentVec(camera, Vec(-0.07, .06, -1))

        if InputDown("lmb") then -- Flamethrower Flame Effects
            local playerVelocity = GetPlayerVelocity()
            playerVelocity = VecAdd(playerVelocity, VecScale(d, -.1))

            local pvel = VecScale(playerVelocity, .7)
            ParticleReset()
            ParticleColor(1, math.random(40, 50) * .01, 0, 1, math.random(20, 40) * .01, 0)
            ParticleEmissive(1, 0)
            ParticleCollide(0.01)
            ParticleTile(5)
            ParticleRadius(.06, 2)
            ParticleAlpha(1, 0)
            ParticleGravity(0, 20)
            ParticleDrag(0, .3)
            SpawnParticle(nozzle.pos, VecAdd(pvel, VecScale(d, 30)), .7) -- medium orange to red

            ParticleColor(1, math.random(75, 85) * .01, .1, 1, math.random(55, 65) * .01, .4)
            ParticleEmissive(3, 0)
            ParticleCollide(.01)
            ParticleTile(5)
            ParticleRadius(.05, 1.5)
            ParticleAlpha(1, 0)
            ParticleGravity(0, 20)
            ParticleDrag(0, .3)
            SpawnParticle(nozzle.pos, VecAdd(pvel, VecScale(d, 30)), .7) -- smaller yellow to orange

            ParticleColor(1, 1, .8, .8, .8, math.random(50, 60) * .01)
            ParticleEmissive(5, 0)
            ParticleCollide(0.01)
            ParticleTile(3)
            ParticleRadius(.1, 1.25)
            ParticleAlpha(.5, 0, "easeout")
            ParticleGravity(0, 20)
            ParticleDrag(0, .3)
            SpawnParticle(nozzle.pos, VecAdd(pvel, VecScale(d, 30)), .7) -- smallest white to white/yellow

            ParticleRadius(.1, 5)
            ParticleColor(0, 0, 0, .1, .1, .1)
            ParticleTile(14)
            ParticleCollide(0.01)
            ParticleAlpha(.6, 0)
            ParticleGravity(0, 20)
            ParticleDrag(0, .3)
            SpawnParticle(nozzle.pos, VecAdd(pvel, VecScale(d, 30)), 1.8) -- bigger black

            -- Play Flamethrower sound
            PlayLoop(soundIncinerate, GetPlayerTransform().pos, (math.random(5, 7) * 0.1))
        end
    end
end
