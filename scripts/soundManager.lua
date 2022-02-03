SoundManager = {
    soundVolume = 0.5,
    soundFlamethrowerActive = nil,
    soundFlamethrowerStart = nil,
    soundFlamethrowerEnd = nil
}

function SoundManager:init()
    self.soundFlamethrowerActive = LoadLoop("sound/flamethrower-active.ogg")
    self.soundFlamethrowerStart = LoadSound("sound/flamethrower-start.ogg")
    self.soundFlamethrowerEnd = LoadSound("sound/flamethrower-end.ogg")
end

function SoundManager:playSoundsIfNecessary()
    if InputPressed("lmb") then
        PlaySound(self.soundFlamethrowerStart, GetPlayerTransform().pos, self.soundVolume)
        PlaySound(self.soundFlamethrowerActive, GetPlayerTransform().pos, self.soundVolume)
    end

    if InputReleased("lmb") then
        PlaySound(self.soundFlamethrowerEnd, GetPlayerTransform().pos, self.soundVolume)
    end

    if InputDown("lmb") then
        PlayLoop(self.soundFlamethrowerActive, GetPlayerTransform().pos, self.soundVolume)
    end
end
