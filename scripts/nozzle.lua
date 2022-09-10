function initNozzle()
    Nozzle = {}

    local function spawnAtPosition(pos, lifetime, flameVelocity)
        SpawnParticle(pos, flameVelocity, lifetime)
        SpawnParticle(pos, flameVelocity, lifetime * 0.8)
        SpawnParticle(pos, flameVelocity, lifetime * 0.7)
    end

    local function spawnParticles(flameVelocity, lifetime)
        local nozzle = Nozzle:getNozzleTransform()
        local startSize = 0.03
        local endSize = 0.8

        ParticleReset()
        ParticleSticky(0.1, 1, 'easein')
        ParticleCollide(0, 0.001, 'easein')
        ParticleGravity(5, -10)
        ParticleDrag(0)
        ParticleStretch(5)
        ParticleTile(5)

        -- white core
        ParticleColor(1, math.random(9, 10) / 10, math.random(9, 10) / 10)
        ParticleEmissive(2, 0)
        ParticleRadius(startSize, endSize)
        ParticleAlpha(0.8, 0.5)
        spawnAtPosition(nozzle.pos, lifetime, flameVelocity)

        -- orange tint
        ParticleColor(1, math.random(28, 44) / 100, 0)
        ParticleEmissive(6, 3)
        ParticleRadius(startSize * 1.5, endSize * 1.5)
        ParticleAlpha(0.8, 0.5)
        spawnAtPosition(nozzle.pos, lifetime, flameVelocity)

        -- red splatter
        ParticleColor(1, math.random(5, 15) / 100, 0)
        ParticleEmissive(4, 2)
        ParticleRadius(startSize * 1.5, endSize * 1.7)
        ParticleAlpha(0.3, 0.7)
        spawnAtPosition(nozzle.pos, lifetime, flameVelocity)

        -- red cloud
        ParticleColor(1, math.random(40, 50) * 0.01, 0, 1, math.random(20, 40) * 0.01, 0)
        ParticleEmissive(3, 1)
        ParticleRadius(startSize * 1.5, endSize * 2.5)
        ParticleAlpha(0.8, 0.5)
        spawnAtPosition(nozzle.pos, lifetime, flameVelocity)
    end

    function Nozzle:getFlameVelocity()
        local nozzle = self:getNozzleTransform()
        local direction = TransformToParentVec(nozzle, Vec(0, 0, -1))
        direction = VecAdd(direction, GetPlayerTransform())

        return VecScale(direction, Knob.flameVelocity * 2)
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
            Transform(transform.pos, toolTransform.rot),
            Engine:voxelCenterOffset()
        )
    end

    function Nozzle:throwFlames(flameVelocity, lifetime)
        if InputDown('usetool') then
            local nozzle = self:getNozzleTransform()
            local fwd = TransformToParentVec(nozzle, Vec(0, 0, -1))
            local hit, maxDist, normal = QueryRaycast(nozzle.pos, fwd, 100)

            table.insert(Flamethrower.flames, Flame:new(nozzle, VecLength(flameVelocity), lifetime * 0.5, hit, maxDist, normal))
            Flamethrower:ammoTick()
            spawnParticles(flameVelocity, lifetime)
        end
    end
end