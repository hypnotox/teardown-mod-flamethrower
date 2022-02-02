strength = 1 -- Debris Blow away Power
maxMass = 100 -- Debris Weight Affected by Blast
maxDist = 20 -- Debris Distance Affected by Blast
power = .1
cooldownTimer = 0

function init()
    RegisterTool("flamethrower", "Flamethrower", "MOD/vox/Flamethrower.vox")
    SetBool("game.tool.flamethrower.enabled", true)
    SetInt("game.tool.flamethrower.ammo", 100)
    soundIncinerate = LoadLoop("incinerate.ogg")
    soundIgnition = LoadSound("ignition.ogg")
    soundExtinguish = LoadSound("extinguish.ogg")
end

function tick(dt)
	if GetString("game.player.tool") == "flamethrower" and GetBool("game.player.canusetool") then
		SetBool("hud.aimdot", false)
	
		-- Ignition and Extinguish sound effects for the Flamethrower
		if GetString("game.player.tool") == "flamethrower" and InputPressed("lmb") then
			PlaySound(soundIgnition, GetPlayerTransform().pos, (math.random(50, 60) * 0.01))
		end
		if GetString("game.player.tool") == "flamethrower" and InputReleased("lmb") then
			PlaySound(soundExtinguish, GetPlayerTransform().pos, (math.random(10, 20) * 0.01))
		end
	
		-- Resting Tool Position
		local offset = Transform(Vec(0.3, -0.3, -.74))
		SetToolTransform(offset, 0.6)
	
		-- Minimum Tool Recoil
		if InputDown("lmb") then
			local offset = Transform(Vec(0.3, -0.3, -.71))
			SetToolTransform(offset, 0.3)
		end
	
		-- Check if Left Mouse Button is Pressed Down activating Flamethrower Flames
		if InputDown("lmb") then
			-- Get fire spawn locations in front of Player
			local t = GetCameraTransform()
			local points = {
				TransformToParentPoint(t, Vec(0.3, -0.3, -1)),
				TransformToParentPoint(t, Vec(0.3, -0.3, -2.5)),
				TransformToParentPoint(t, Vec(0.7, -0.7, -2.8)),
				TransformToParentPoint(t, Vec(0.7, .1, -3.1)),
				TransformToParentPoint(t, Vec(-0.1, -0.7, -3.4)),
				TransformToParentPoint(t, Vec(-0.1, .1, -3.7)),
				TransformToParentPoint(t, Vec(0.2, -0.2, -4)),
				TransformToParentPoint(t, Vec(0.7, -0.7, -4.3)),
				TransformToParentPoint(t, Vec(0.7, 0.3, -4.6)),
				TransformToParentPoint(t, Vec(-0.3, -0.7, -4.9)),
				TransformToParentPoint(t, Vec(-0.3, 0.3, -5.2)),
				TransformToParentPoint(t, Vec(0.2, -0.2, -5.5)),
				TransformToParentPoint(t, Vec(0.8, -0.8, -5.8)),
				TransformToParentPoint(t, Vec(0.8, 0.4, -6.1)),
				TransformToParentPoint(t, Vec(-0.4, -0.8, -6.4)),
				TransformToParentPoint(t, Vec(-0.4, 0.4, -6.7)),
				TransformToParentPoint(t, Vec(0.1, -0.1, -7)),
				TransformToParentPoint(t, Vec(0.8, -0.8, -7.3)),
				TransformToParentPoint(t, Vec(0.8, 0.6, -7.6)),
				TransformToParentPoint(t, Vec(-0.6, -0.8, -7.9)),
				TransformToParentPoint(t, Vec(-0.6, 0.6, -8.2)),
				TransformToParentPoint(t, Vec(0.1, -0.1, -8.5)),
				TransformToParentPoint(t, Vec(0.9, -0.9, -8.8)),
				TransformToParentPoint(t, Vec(0.9, 0.7, -9.1)),
				TransformToParentPoint(t, Vec(-0.7, -0.9, -9.4)),
				TransformToParentPoint(t, Vec(-0.7, 0.7, -9.7)),
				TransformToParentPoint(t, Vec(0.1, -0.1, -10)),
				TransformToParentPoint(t, Vec(0.7, -0.7, -10.5)),
				TransformToParentPoint(t, Vec(0.7, 0.5, -11)),
				TransformToParentPoint(t, Vec(-0.5, -0.7, -11.5)),
				TransformToParentPoint(t, Vec(-0.5, 0.5, -12)),
				TransformToParentPoint(t, Vec(0, 0, -12.5)),
				TransformToParentPoint(t, Vec(0.4, -0.4, -13)),
				TransformToParentPoint(t, Vec(0.4, 0.4, -13.5)),
				TransformToParentPoint(t, Vec(-0.4, -0.4, -14)),
				TransformToParentPoint(t, Vec(-0.4, 0.4, -14.5)),
				TransformToParentPoint(t, Vec(0, 0, -15)),
				TransformToParentPoint(t, Vec(0.3, -0.3, -15.5)),
				TransformToParentPoint(t, Vec(-0.3, 0.3, -16)),
			}
	
			-- make tons of fire if something combustible is there
			for _, p in ipairs(points) do
				SpawnFire(p)
			end

			PointLight(c, 1, 0.7, 0.3, 0.40)
			PointLight(d, 1, 0.7, 0.3, 0.40)
			PointLight(e, 1, 0.7, 0.3, 0.40)
			PointLight(f, 1, 0.7, 0.3, 0.40)
			PointLight(g, 1, 0.7, 0.3, 0.40)
			PointLight(h, 1, 0.7, 0.3, 0.40)
			PointLight(i, 1, 0.7, 0.3, 0.40)
		end
	end
end

function update(dt)
    if cooldownTimer > 0 then
        cooldownTimer = cooldownTimer - dt
    end

    if GetString("game.player.tool") == "flamethrower" and GetBool("game.player.canusetool") then
        -- Compute hit points and front direction of Player Weapon in world space
        local t = GetCameraTransform()
        local pp = TransformToParentPoint(t, Vec(.45, -.5, -1.65))
        local d = TransformToParentVec(t, Vec(-0.07, .06, -1))

        if InputDown("lmb") then -- Flamethrower Flame Effects
            local v = GetPlayerVelocity()
            v = VecAdd(v, VecScale(d, -.1))

            local pvel = VecScale(v, .7)
            ParticleReset()
            ParticleColor(1, math.random(40, 50) * .01, 0, 1, math.random(20, 40) * .01, 0)
            ParticleEmissive(1, 0)
            ParticleCollide(0.01)
            ParticleTile(5)
            ParticleRadius(.06, 2)
            ParticleAlpha(1, 0)
            ParticleGravity(0, 20)
            ParticleDrag(0, .3)
            SpawnParticle(pp, VecAdd(pvel, VecScale(d, 30)), .7) -- medium orange to red
            ParticleColor(1, math.random(75, 85) * .01, .1, 1, math.random(55, 65) * .01, .4)
            ParticleEmissive(3, 0)
            ParticleCollide(.01)
            ParticleTile(5)
            ParticleRadius(.05, 1.5)
            ParticleAlpha(1, 0)
            ParticleGravity(0, 20)
            ParticleDrag(0, .3)
            SpawnParticle(pp, VecAdd(pvel, VecScale(d, 30)), .7) -- smaller yellow to orange
            ParticleColor(1, 1, .8, .8, .8, math.random(50, 60) * .01)
            ParticleEmissive(5, 0)
            ParticleCollide(0.01)
            ParticleTile(3)
            ParticleRadius(.1, 1.25)
            ParticleAlpha(.5, 0, "easeout")
            ParticleGravity(0, 20)
            ParticleDrag(0, .3)
            SpawnParticle(pp, VecAdd(pvel, VecScale(d, 30)), .7) -- smallest white to white/yellow
            ParticleRadius(.1, 5)
            ParticleColor(0, 0, 0, .1, .1, .1)
            ParticleTile(14)
            ParticleCollide(0.01)
            ParticleAlpha(.6, 0)
            ParticleGravity(0, 20)
            ParticleDrag(0, .3)
            SpawnParticle(pp, VecAdd(pvel, VecScale(d, 30)), 1.8) -- bigger black
            -- Play Flamethrower sound
            PlayLoop(soundIncinerate, GetPlayerTransform().pos, (math.random(5, 7) * 0.1))
        end
    end
end

