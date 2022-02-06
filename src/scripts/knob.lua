Knob = {
    flameVelocity = 20,
    flameVelocityMin = 5,
    flameVelocityMax = 40,
    changePerSecond = 10,
    keybinds = {},
    angle = 0,
}

function Knob:init()
    self.keybinds.decrease = GetString('savegame.mod.features.nozzle.keybinds.decrease') or 'leftarrow'
    self.keybinds.increase = GetString('savegame.mod.features.nozzle.keybinds.increase') or 'rightarrow'
end

function Knob:tick()
    local knobShape = self:getShape()

    if InputDown('usetool') then
        SetShapeEmissiveScale(knobShape, 0.25)
    else
        SetShapeEmissiveScale(knobShape, 0)
    end

    if InputDown(self.keybinds.decrease) and not InputDown(self.keybinds.increase) and self.flameVelocity >= self.flameVelocityMin then
        local change = self.changePerSecond * GetTimeStep()

        self.flameVelocity = self.flameVelocity - change
        self:rotateKnob(-change)
    end

    if InputDown(self.keybinds.increase) and not InputDown(self.keybinds.decrease) and self.flameVelocity <= self.flameVelocityMax then
        local change = self.changePerSecond * GetTimeStep()

        self.flameVelocity = self.flameVelocity + change
        self:rotateKnob(change)
    end
end

function Knob:rotateKnob(degree)
    local knobShape = self:getShape()
    local knobTransform = GetShapeLocalTransform(knobShape)

    SetShapeLocalTransform(
        knobShape,
        Transform(
            knobTransform.pos,
            QuatRotateQuat(knobTransform.rot, QuatEuler(0, degree, 0))
        )
    )
end

function Knob:getShape()
    local tool = GetToolBody()
    local shapes = GetBodyShapes(tool)

    return shapes[2]
end
