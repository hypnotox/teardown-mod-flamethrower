Knob = {
    flameVelocity = 15,
    flameVelocityDefault = 15,
    flameVelocityMin = 5,
    flameVelocityMax = 25,
    changePerSecond = 10,
    keybinds = {
        decrease = 'leftarrow',
        increase = 'rightarrow'
    },
}

-- Physical knob rotation (degrees) currently applied relative to the model's
-- default orientation. A file-scope local so it resets to 0 on re-execution —
-- exactly when a quickload re-registers the tool and the knob shape snaps back
-- to its model default. The shape transform and this value therefore share a
-- lifecycle, keeping the visual in lockstep with the persisted flameVelocity.
local appliedAngle = 0

-- Reads keybinds from the registry, falling back to defaults. Does not touch
-- flameVelocity: it is a field on the global Knob table, so Teardown's
-- quicksave _G snapshot restores the player's value over the file-scope
-- default on quickload (no registry key is involved).
function Knob:loadConfig()
    self.keybinds.decrease = Registry.getStringOr('savegame.mod.features.nozzle.keybinds.decrease', 'leftarrow')
    self.keybinds.increase = Registry.getStringOr('savegame.mod.features.nozzle.keybinds.increase', 'rightarrow')
end

function Knob:tick()
    local knobShape = self:getShape()

    if InputDown('usetool') and GetBool("game.player.canusetool") then
        SetShapeEmissiveScale(knobShape, 0.25)
    else
        SetShapeEmissiveScale(knobShape, 0)
    end

    local change = self.changePerSecond * GetTimeStep()

    if InputDown(self.keybinds.decrease) and not InputDown(self.keybinds.increase) then
        self.flameVelocity = math.max(self.flameVelocityMin, self.flameVelocity - change)
    elseif InputDown(self.keybinds.increase) and not InputDown(self.keybinds.decrease) then
        self.flameVelocity = math.min(self.flameVelocityMax, self.flameVelocity + change)
    end

    self:syncRotation()
end

-- Drives the physical knob from the value rather than accumulating per-frame
-- nudges, so it stays correct after a quickload (where flameVelocity persists
-- but the shape resets to its model default). desiredAngle is measured from the
-- default orientation; the sign matches the original (lower velocity turns the
-- knob one way, higher the other).
function Knob:syncRotation()
    local desiredAngle = self.flameVelocityDefault - self.flameVelocity
    local delta = desiredAngle - appliedAngle

    if delta ~= 0 then
        self:rotateKnob(delta)
        appliedAngle = desiredAngle
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
