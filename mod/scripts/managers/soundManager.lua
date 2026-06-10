SoundManager = {
    soundVolume = 0.5,
    outOfAmmo = false,
    soundFlamethrowerActive = nil,
    soundFlamethrowerStart = nil,
    soundFlamethrowerEnd = nil
}

-- Loads sound handles. Handles are runtime-only and must be reloaded on every
-- script execution, including after a quickload.
function SoundManager:load()
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
