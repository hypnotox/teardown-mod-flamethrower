Flamethrower = {
    maxAmmo = 100,
    ammoPerSecond = 5,
    maxFlameDist = 15,
    flameVelocity = 30,
    flames = {},
    nozzleOffset = Vec(0.3, -0.3, -1.1),
}

function Flamethrower:init()
    local modelPath = 'MOD/vox/Flamethrower.vox'

    if Debug.enabled then
        modelPath = 'MOD/vox/FlamethrowerDebug.vox'
    end

    RegisterTool('hypnotox_flamethrower', 'Flamethrower', modelPath)
    SetBool('game.tool.hypnotox_flamethrower.enabled', true)
    SetFloat('game.tool.hypnotox_flamethrower.ammo', Flamethrower.maxAmmo)
    SoundManager:init()
end

function Flamethrower:tick()
    SetBool('hud.aimdot', false)
    Flamethrower:setToolPosition()
    Flamethrower:throwFlames()
end

function Flamethrower:throwFlames()
    SoundManager:playSoundsIfNecessary()
    ParticleManager:spawnNozzleFlameParticles()

    if GetInt('game.tool.hypnotox_flamethrower.ammo') > 0 and InputDown('usetool') then
        local lifetime = 1
        local nozzle = Flamethrower:getNozzleTransform()
        local direction = TransformToParentVec(nozzle, Vec(0, 0, -1))
        direction = VecAdd(direction, TransformToParentVec(GetPlayerTransform()))
        local flameVelocity = VecScale(direction, self.flameVelocity)
        Debug:watch('FlameVelocity', Debug:dumpString(flameVelocity))
        Debug:watch('FlameVelocityMagnitude', Debug:dumpString(VecLength(flameVelocity)))

        FlameManager:throwFlames(flameVelocity, lifetime * 0.5)
        ParticleManager:spawnFlameParticles(flameVelocity, lifetime)
    end

    FlameManager:emulateFlames()
end

function Flamethrower:ammoTick()
    local ammoUsed = self.ammoPerSecond * GetTimeStep()
    local ammoLeft = GetFloat('game.tool.hypnotox_flamethrower.ammo') - ammoUsed

    SetFloat('game.tool.hypnotox_flamethrower.ammo', ammoLeft)
end

function Flamethrower:setToolPosition()
    if InputDown('usetool') and GetInt('game.tool.hypnotox_flamethrower.ammo') > 0 then
        local offset = Transform(Vec(0.3, -0.3, -0.71))
        SetToolTransform(offset, 0.3)
    else
        local offset = Transform(Vec(0.3, -0.3, -0.74))
        SetToolTransform(offset, 0.6)
    end
end

function Flamethrower:getKnobTransform()
    local tool = GetToolBody()
    local shapes = GetBodyShapes(tool)
    local toolTransform = GetBodyTransform(tool)
    local transform = TransformCopy(GetShapeWorldTransform(shapes[2]))
    transform.rot = QuatCopy(toolTransform.rot)
    transform.pos = TransformToParentPoint(transform, Vec(0.025, 0.025, -0.025))

    return transform
end

function Flamethrower:getFireStarterTransform()
    local tool = GetToolBody()
    local shapes = GetBodyShapes(tool)
    local toolTransform = GetBodyTransform(tool)
    local transform = TransformCopy(GetShapeWorldTransform(shapes[3]))
    transform.rot = QuatCopy(toolTransform.rot)
    transform.pos = TransformToParentPoint(transform, Vec(0.025, 0.025, -0.025))

    return transform
end

function Flamethrower:getNozzleTransform()
    local tool = GetToolBody()
    local shapes = GetBodyShapes(tool)
    local toolTransform = GetBodyTransform(tool)
    local transform = TransformCopy(GetShapeWorldTransform(shapes[4]))
    transform.rot = QuatCopy(toolTransform.rot)
    transform.pos = TransformToParentPoint(transform, Vec(0.025, 0.025, -0.025))

    return transform
end
