-- SoundManager (presentation): start/loop/end flamethrower audio. Pure client.
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
    if InputPressed('usetool') and State:hasAmmo() then
        PlaySound(self.soundFlamethrowerStart, GetPlayerTransform().pos, self.soundVolume)
        PlaySound(self.soundFlamethrowerActive, GetPlayerTransform().pos, self.soundVolume)
    end

    if InputReleased('usetool') and State:hasAmmo() then
        PlaySound(self.soundFlamethrowerEnd, GetPlayerTransform().pos, self.soundVolume)
    end

    if InputDown('usetool') and State:hasAmmo() then
        PlayLoop(self.soundFlamethrowerActive, GetPlayerTransform().pos, self.soundVolume)
    end

    if not self.outOfAmmo and not State:hasAmmo() then
        PlaySound(self.soundFlamethrowerEnd, GetPlayerTransform().pos, self.soundVolume)
        self.outOfAmmo = true
    end
end
