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

-- Registry keys storing the knob shape's model-default local transform.
local DEFAULT_KEY = 'savegame.mod.nozzle.knob_default'

-- Cached model-default local transform (file-scope: re-resolved after a quickload
-- re-execution). Teardown does not serialize the shape transform — it reverts to
-- this default on save/load while flameVelocity persists via the _G snapshot — so
-- we re-derive the rotation from the value every tick and self-correct. The base
-- itself is resolved from the registry (which DOES survive quickload), captured
-- once from the live shape; capturing it after a load is unreliable because the
-- shape reads as origin (no tool body yet) and then settles through intermediate
-- poses before reaching the real default.
local defaultTransform = nil
local lastPos = nil

-- Reads keybinds from the registry, falling back to defaults. Does not touch
-- flameVelocity: it is a field on the global Knob table, so Teardown's
-- quicksave _G snapshot restores the player's value over the file-scope
-- default on quickload (no registry key is involved).
function Knob:loadConfig()
    self.keybinds.decrease = Registry.getStringOr('savegame.mod.features.nozzle.keybinds.decrease', 'leftarrow')
    self.keybinds.increase = Registry.getStringOr('savegame.mod.features.nozzle.keybinds.increase', 'rightarrow')
end

function Knob:tick()
    local tool = GetToolBody()

    if tool == 0 then
        return
    end

    local knobShape = GetBodyShapes(tool)[2]

    if not knobShape then
        return
    end

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

    self:applyRotation(knobShape)
end

-- Sets the knob's absolute rotation from the value: the model default rotated by
-- (default - value) degrees about the knob axis. Re-asserted every tick so a
-- shape the engine reset on save/load is corrected next frame.
function Knob:applyRotation(shape)
    if not defaultTransform then
        defaultTransform = self:resolveDefault(shape)

        if not defaultTransform then
            return
        end
    end

    local axisTransform = Transform(Vec(Engine.voxelSize * 0.5, Engine.voxelSize * 6.5, 0))
    local base = TransformToLocalTransform(axisTransform, defaultTransform)

    axisTransform.rot = QuatEuler(0, 0, self.flameVelocityDefault - self.flameVelocity)

    SetShapeLocalTransform(shape, TransformToParentTransform(axisTransform, base))
end

-- Returns the model-default transform: the stored registry value if present
-- (survives quickload), otherwise captures it from the shape once it has settled
-- (stopped moving at a non-origin pose) and stores it for all future loads.
-- Returns nil while still waiting for the shape to settle.
function Knob:resolveDefault(shape)
    if HasKey(DEFAULT_KEY .. '.qw') then
        return Transform(
            Vec(GetFloat(DEFAULT_KEY .. '.px'), GetFloat(DEFAULT_KEY .. '.py'), GetFloat(DEFAULT_KEY .. '.pz')),
            Quat(GetFloat(DEFAULT_KEY .. '.qx'), GetFloat(DEFAULT_KEY .. '.qy'), GetFloat(DEFAULT_KEY .. '.qz'), GetFloat(DEFAULT_KEY .. '.qw'))
        )
    end

    local current = GetShapeLocalTransform(shape)

    -- Not-ready state right after a load: shape sits at the origin.
    if VecLength(current.pos) < 0.001 then
        lastPos = nil
        return nil
    end

    -- Wait for the pose to stop changing before trusting it as the default.
    if not lastPos then
        lastPos = current.pos
        return nil
    end

    local dx = current.pos[1] - lastPos[1]
    local dy = current.pos[2] - lastPos[2]
    local dz = current.pos[3] - lastPos[3]
    lastPos = current.pos

    if (dx * dx + dy * dy + dz * dz) > 0.0000001 then
        return nil
    end

    SetFloat(DEFAULT_KEY .. '.px', current.pos[1])
    SetFloat(DEFAULT_KEY .. '.py', current.pos[2])
    SetFloat(DEFAULT_KEY .. '.pz', current.pos[3])
    SetFloat(DEFAULT_KEY .. '.qx', current.rot[1])
    SetFloat(DEFAULT_KEY .. '.qy', current.rot[2])
    SetFloat(DEFAULT_KEY .. '.qz', current.rot[3])
    SetFloat(DEFAULT_KEY .. '.qw', current.rot[4])

    return current
end

-- Forgets the stored default so it is re-captured fresh. Called from init()
-- (fresh level load only, never quickload), so the default is re-derived from
-- the current model each session — self-healing after a .vox change — while
-- quickloads within a session keep reusing the stored value.
function Knob:clearStoredDefault()
    ClearKey(DEFAULT_KEY)
    defaultTransform = nil
    lastPos = nil
end

function Knob:getShape()
    local tool = GetToolBody()
    local shapes = GetBodyShapes(tool)

    return shapes[2]
end
