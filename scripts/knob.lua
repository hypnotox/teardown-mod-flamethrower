Knob = {
    flameVelocity = 20,
    flameVelocityMin = 5,
    flameVelocityMax = 40,
    changePerSecond = 10,
}

function Knob:tick()
    Debug:shapeOutline(knobShape)

    if InputPressed('usetool') then
        SetShapeEmissiveScale(knobShape, 100)
    end

    if InputDown('leftarrow') and not InputDown('rightarrow') and self.flameVelocity >= self.flameVelocityMin then
        local change = self.changePerSecond * GetTimeStep()

        self.flameVelocity = self.flameVelocity - change
        self:rotateKnob(-change)
    end

    if InputDown('rightarrow') and not InputDown('leftarrow') and self.flameVelocity <= self.flameVelocityMax then
        local change = self.changePerSecond * GetTimeStep()

        self.flameVelocity = self.flameVelocity + change
        self:rotateKnob(change)
    end
end

function Knob:rotateKnob(degree)
    local knobShape = Flamethrower.getKnobShape()
    local knobTransform = GetShapeLocalTransform(knobShape)

    SetShapeLocalTransform(
        knobShape,
        Transform(
            knobTransform.pos,
            QuatRotateQuat(knobTransform.rot, QuatEuler(0, degree, 0))
        )
    )
end
