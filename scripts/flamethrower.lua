function initFlamethrower()
    Flamethrower = {
        maxAmmo = 100,
        ammoPerSecond = 5,
        flames = {}
    }

    -- Teardown API methods

    function Flamethrower:init()
        local modelPath = 'MOD/vox/Flamethrower.vox'
        local inventorySlot = GetInt('savegame.mod.features.inventory.slot')

        if inventorySlot == 0 then
            inventorySlot = 6
        end

        if Debug.enabled then
            modelPath = 'MOD/vox/FlamethrowerDebug.vox'
        end

        Debug:dump(inventorySlot, 'Slot')

        RegisterTool('hypnotox_flamethrower', 'Flamethrower', modelPath, inventorySlot)
        SetBool('game.tool.hypnotox_flamethrower.enabled', true)
        SetFloat('game.tool.hypnotox_flamethrower.ammo', self.maxAmmo)

        Knob:init()
    end

    function Flamethrower:tick()
        SetBool('hud.aimdot', false)
        self:setToolPosition()

        SoundManager:tick()
        Knob:tick()

        for i = 1, #self.flames, 1 do
            self.flames[i]:tick()
        end

        if not GetBool("game.player.canusetool") then
            return
        end

        local fireStarterShape = FireStarter:getShape()

        if GetInt('game.tool.hypnotox_flamethrower.ammo') > 0 then
            SetShapeEmissiveScale(fireStarterShape, 0.5)
            FireStarter:spawnParticles()
        else
            SetShapeEmissiveScale(fireStarterShape, 0)
        end
    end

    function Flamethrower:update()
        if GetInt('game.tool.hypnotox_flamethrower.ammo') > 0 and InputDown('usetool') then
            local lifetime = 1.3
            local flameVelocity = Nozzle:getFlameVelocity()

            Nozzle:throwFlames(flameVelocity, lifetime)
        end

        for i = #self.flames, 1, -1 do
            self.flames[i]:update()

            if not self.flames[i].isAlive then
                table.remove(self.flames, i)
            end
        end
    end

    -- Helper methods

    function Flamethrower:ammoTick()
        local ammoUsed = self.ammoPerSecond * GetTimeStep()
        local ammoLeft = GetFloat('game.tool.hypnotox_flamethrower.ammo') - ammoUsed

        SetFloat('game.tool.hypnotox_flamethrower.ammo', ammoLeft)
    end

    function Flamethrower:setToolPosition()
        if InputDown('usetool') and GetInt('game.tool.hypnotox_flamethrower.ammo') > 0 and GetBool("game.player.canusetool") then
            local offset = Transform(Vec(0.3, -0.5, -0.65))
            SetToolTransform(offset, 0.1)
        else
            local offset = Transform(Vec(0.3, -0.5, -0.68))
            SetToolTransform(offset, 0.5)
        end
    end
end
