SoundManager = {
    soundVolume = 0.5,
    soundFlamethrowerActive = nil,
    soundFlamethrowerStart = nil,
    soundFlamethrowerEnd = nil,
    outOfAmmo = false
}

function SoundManager:init()
    self.soundFlamethrowerActive = LoadLoop('sound/flamethrower-active.ogg')
    self.soundFlamethrowerStart = LoadSound('sound/flamethrower-start.ogg')
    self.soundFlamethrowerEnd = LoadSound('sound/flamethrower-end.ogg')
end

function SoundManager:tick()
    if InputPressed('usetool') and GetInt('game.tool.hypnotox_flamethrower.ammo') > 0 then
        PlaySound(self.soundFlamethrowerStart, GetPlayerTransform().pos, self.soundVolume)
        PlaySound(self.soundFlamethrowerActive, GetPlayerTransform().pos, self.soundVolume)
    end

    if InputReleased('usetool') and GetInt('game.tool.hypnotox_flamethrower.ammo') > 0 then
        PlaySound(self.soundFlamethrowerEnd, GetPlayerTransform().pos, self.soundVolume)
    end

    if InputDown('usetool') and GetInt('game.tool.hypnotox_flamethrower.ammo') > 0 then
        PlayLoop(self.soundFlamethrowerActive, GetPlayerTransform().pos, self.soundVolume)
    end

    if not self.outOfAmmo and GetInt('game.tool.hypnotox_flamethrower.ammo') == 0 then
        PlaySound(self.soundFlamethrowerEnd, GetPlayerTransform().pos, self.soundVolume)
        self.outOfAmmo = true
    end
end
