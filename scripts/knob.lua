Knob = {
    flameVelocity = 20,
    flameVelocityMin = 5,
    flameVelocityMax = 40,
    flameVelocityDefault = 20,
    changePerSecond = 10,
}

function Knob:init()
    self:setDefaultVelocity()
end

function Knob:tick()
    Debug:watch('KnobDegree', degree)
    Debug:shapeOutline(knobShape)

    if InputPressed('usetool') then
        SetShapeEmissiveScale(knobShape, 100)
    end

    if InputPressed('downarrow') then
        local change = self.flameVelocityDefault - self.flameVelocity
        self:rotateKnob(change)
        self:setDefaultVelocity()
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

function Knob:setDefaultVelocity()
    self.flameVelocity = (self.flameVelocityMin + self.flameVelocityMax) / 2
end
