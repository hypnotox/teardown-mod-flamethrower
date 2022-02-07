Knob = {
    flameVelocity = 15,
    flameVelocityMin = 5,
    flameVelocityMax = 25,
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
        self:rotateKnob(change)
    end

    if InputDown(self.keybinds.increase) and not InputDown(self.keybinds.decrease) and self.flameVelocity <= self.flameVelocityMax then
        local change = self.changePerSecond * GetTimeStep()

        self.flameVelocity = self.flameVelocity + change
        self:rotateKnob(-change)
    end
end

function Knob:rotateKnob(angle)
    local shape = self:getShape()
    local axisTransform = Transform(Vec(Engine.voxelSize * 0.5, Engine.voxelSize * 6.5, 0))
    local shapeTransform = TransformToLocalTransform(axisTransform, GetShapeLocalTransform(shape))

    axisTransform.rot = QuatEuler(0, 0, angle)
    shapeTransform = TransformToParentTransform(axisTransform, shapeTransform)

    SetShapeLocalTransform(
        shape,
        shapeTransform
    )
end

function Knob:getShape()
    local tool = GetToolBody()
    local shapes = GetBodyShapes(tool)

    return shapes[2]
end
