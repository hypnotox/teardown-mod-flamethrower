Flamethrower = {
    maxAmmo = 100,
    ammoPerSecond = 5,
    flameVelocity = 30,
}

-- Teardown API methods

function Flamethrower:init()
    local modelPath = 'MOD/vox/Flamethrower.vox'

    if Debug.enabled then
        modelPath = 'MOD/vox/FlamethrowerDebug.vox'
    end

    RegisterTool('hypnotox_flamethrower', 'Flamethrower', modelPath)
    SetBool('game.tool.hypnotox_flamethrower.enabled', true)
    SetFloat('game.tool.hypnotox_flamethrower.ammo', self.maxAmmo)
    SoundManager:init()
    Knob:init()
end

function Flamethrower:tick()
    SetBool('hud.aimdot', false)
    self:setToolPosition()
    SoundManager:playSoundsIfNecessary()
    FlameManager:tick()
    Knob:tick()
    local fireStarterShape = Flamethrower:getFireStarterShape()

    if GetInt('game.tool.hypnotox_flamethrower.ammo') > 0 then
        SetShapeEmissiveScale(fireStarterShape, 0.5)
        ParticleManager:spawnNozzleFlameParticles()
    else
        SetShapeEmissiveScale(fireStarterShape, 0)
    end
end

function Flamethrower:update()
    if GetInt('game.tool.hypnotox_flamethrower.ammo') > 0 and InputDown('usetool') then
        local lifetime = 1
        local flameVelocity = self:getFlameVelocity()

        FlameManager:throwFlames(flameVelocity, lifetime * 0.5)
        ParticleManager:spawnFlameParticles(flameVelocity, lifetime)
    end

    FlameManager:update()
end

-- Helper methods

function Flamethrower:ammoTick()
    local ammoUsed = self.ammoPerSecond * GetTimeStep()
    local ammoLeft = GetFloat('game.tool.hypnotox_flamethrower.ammo') - ammoUsed

    SetFloat('game.tool.hypnotox_flamethrower.ammo', ammoLeft)
end

function Flamethrower:setToolPosition()
    if InputDown('usetool') and GetInt('game.tool.hypnotox_flamethrower.ammo') > 0 then
        local offset = Transform(Vec(0.3, -0.5, -0.65))
        SetToolTransform(offset, 0.1)
    else
        local offset = Transform(Vec(0.3, -0.5, -0.68))
        SetToolTransform(offset, 0.5)
    end
end

-- Getters

function Flamethrower:getFlameVelocity()
    local nozzle = Flamethrower:getNozzleTransform()
    local direction = TransformToParentVec(nozzle, Vec(0, 0, -1))
    direction = VecAdd(direction, TransformToParentVec(GetPlayerTransform()))

    return VecScale(direction, Knob.flameVelocity * 2)
end

function Flamethrower:getKnobShape()
    local tool = GetToolBody()
    local shapes = GetBodyShapes(tool)

    return shapes[2]
end

function Flamethrower:getKnobTransform()
    local tool = GetToolBody()
    local shape = self:getKnobShape()
    local min, max = GetShapeBounds(shape)
    local center = VecLerp(min, max, 0.5)
    local toolTransform = GetBodyTransform(tool)

    return Transform(center, QuatCopy(toolTransform.rot))
end

function Flamethrower:getFireStarterShape()
    local tool = GetToolBody()
    local shapes = GetBodyShapes(tool)

    return shapes[3]
end

function Flamethrower:getFireStarterTransform()
    local tool = GetToolBody()
    local shape = self:getFireStarterShape()
    local min, max = GetShapeBounds(shape)
    local center = VecLerp(min, max, 0.5)
    local toolTransform = GetBodyTransform(tool)

    return Transform(center, QuatCopy(toolTransform.rot))
end

function Flamethrower:getNozzleShape()
    local tool = GetToolBody()
    local shapes = GetBodyShapes(tool)

    return shapes[4]
end

function Flamethrower:getNozzleTransform()
    local tool = GetToolBody()
    local shape = self:getNozzleShape()
    local min, max = GetShapeBounds(shape)
    local center = VecLerp(min, max, 0.5)
    local toolTransform = GetBodyTransform(tool)

    return Transform(center, QuatCopy(toolTransform.rot))
end
