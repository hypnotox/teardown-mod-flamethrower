SoundManager = {
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
        PlaySound(Flamethrower.soundFlamethrowerStart, GetPlayerTransform().pos, Flamethrower.soundVolume)
        PlaySound(Flamethrower.soundFlamethrowerActive, GetPlayerTransform().pos, Flamethrower.soundVolume)
    end

    if InputReleased("lmb") then
        PlaySound(Flamethrower.soundFlamethrowerEnd, GetPlayerTransform().pos, Flamethrower.soundVolume)
    end

    if InputDown("lmb") then
        PlayLoop(Flamethrower.soundFlamethrowerActive, GetPlayerTransform().pos, Flamethrower.soundVolume)
    end
end
