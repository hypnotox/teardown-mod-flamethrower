Knob = {
    flameVelocity = 20,
    flameVelocityMin = 5,
    flameVelocityMax = 40,
    changePerSecond = 10,
    keybinds = {},
    angle = 0,
}

function Knob:init()
    self.keybinds.decrease = GetString('savegame.mod.features.nozzle.keybinds.decrease')
    self.keybinds.increase = GetString('savegame.mod.features.nozzle.keybinds.increase')
end

function Knob:tick()
    local knobShape = self:getKnobShape()

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
    local knobShape = self:getKnobShape()
    local knobTransform = GetShapeLocalTransform(knobShape)

    SetShapeLocalTransform(
        knobShape,
        Transform(
            knobTransform.pos,
            QuatRotateQuat(knobTransform.rot, QuatEuler(0, degree, 0))
        )
    )
end

function Knob:getKnobShape()
    local tool = GetToolBody()
    local shapes = GetBodyShapes(tool)

    return shapes[2]
end

function Knob:getKnobTransform()
    local tool = GetToolBody()
    local shape = self:getKnobShape()
    local transform = GetShapeLocalTransform(shape)
    local center = VecAdd(transform.pos, Vec(Engine.voxelSize * 0.5, Engine.voxelSize * 0.5, -Engine.voxelSize * 0.5))
    local toolTransform = GetBodyTransform(tool)

    return Transform(center, QuatCopy(toolTransform.rot))
end
