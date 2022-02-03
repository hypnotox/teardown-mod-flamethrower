Flamethrower = {
    maxAmmo = 100,
    ammoPerSecond = 5,
    maxFlameDist = 15,
    flameVelocity = 20,
    flames = {},
    nozzleOffset = Vec(0.3, -0.3, -1.1),
}

function Flamethrower:init()
    RegisterTool('hypnotox_flamethrower', 'Flamethrower', 'MOD/vox/Flamethrower.vox')
    SetBool('game.tool.hypnotox_flamethrower.enabled', true)
    SetFloat('game.tool.hypnotox_flamethrower.ammo', Flamethrower.maxAmmo)
    SoundManager:init()
end

function Flamethrower:tick()
    SetBool('hud.aimdot', false)
    Flamethrower:setToolPosition()

    if GetInt('game.tool.hypnotox_flamethrower.ammo') > 0 then
        SoundManager:playSoundsIfNecessary()
        ParticleManager:spawnNozzleFlameParticles()
        ParticleManager:spawnFlameParticles()
    end

    FlameManager:emulateFlames()
end

function Flamethrower:update()
    if GetInt('game.tool.hypnotox_flamethrower.ammo') > 0 then
        FlameManager:throwFlames()
    end
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
