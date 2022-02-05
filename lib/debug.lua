Debug = {
    enabled = false
}

function Debug:enable()
    self.enabled = true
    DebugPrint('Debug is enabled!')
end

function Debug:tick()
    Debug:watch('player', Debug:dumpString(GetPlayerTransform()))
    Debug:watch('camera', Debug:dumpString(GetCameraTransform()))

    local tool = GetToolBody()
    local toolTransform = GetBodyTransform(tool)
    Debug:watch('tool', Debug:dumpString(toolTransform))

    local fireStarterTransform = Flamethrower:getFireStarterTransform()
    Debug:watch('fireStarter', Debug:dumpString(fireStarterTransform))
    Debug:cross(fireStarterTransform.pos, 0, 255, 0, 0.7)

    local nozzleTransform = Flamethrower:getNozzleTransform()
    Debug:watch('nozzle', Debug:dumpString(nozzleTransform))
    Debug:cross(nozzleTransform.pos, 255, 0, 0, 0.7)

    local knobTransform = Flamethrower:getKnobTransform()
    Debug:watch('knob', Debug:dumpString(knobTransform))
    Debug:cross(knobTransform.pos, 255, 0, 0, 0.7)

    local flameVelocity = Flamethrower:getFlameVelocity()
    Debug:watch('FlameVelocity', Debug:dumpString(flameVelocity))
    Debug:watch('FlameVelocityMagnitude', Debug:dumpString(VecLength(flameVelocity)))

    Debug:watch('FireCount', GetFireCount())
    Debug:watch('FlamesCount', #FlameManager.flames)
end

-- Debug functions --

function Debug:line(p0, p1, r, g, b, a)
    if not self.enabled then
        return
    end

    DebugLine(p0, p1, r or 255, g or 255, b or 255, a or 1)
end

function Debug:cross(p0, r, g, b, a)
    if not self.enabled then
        return
    end

    DebugCross(p0, r or 255, g or 255, b or 255, a or 1)
end

function Debug:watch(name, value)
    if not self.enabled then
        return
    end

    DebugWatch(name, value)
end

function Debug:print(message)
    if not self.enabled then
        return
    end

    DebugPrint(message)
end

-- Body and shape functions --

function Debug:bodyOutline(handle, a)
    if not self.enabled then
        return
    end

    DrawBodyOutline(handle, a or 1)
end

function Debug:bodyOutline(handle, r, g, b, a)
    if not self.enabled then
        return
    end

    DrawBodyOutline(handle, r or 255, g or 255, b or 255, a or 1)
end

function Debug:bodyHighlight(handle, amount)
    if not self.enabled then
        return
    end

    DrawShapeHighlight(handle, amount)
end

function Debug:shapeOutline(handle, a)
    if not self.enabled then
        return
    end

    DrawBodyOutline(handle, a or 1)
end

function Debug:shapeOutline(handle, r, g, b, a)
    if not self.enabled then
        return
    end

    DrawShapeOutline(handle, r or 255, g or 255, b or 255, a or 1)
end

function Debug:shapeHighlight(handle, amount)
    if not self.enabled then
        return
    end

    DrawShapeHighlight(handle, amount)
end

-- Other dump functions --

-- Used to dump a variable onto screen
function Debug:dump(object)
    self:print(self:dumpString(object))
end

function Debug:dumpString(object)
    if (type(object) == "number") or (type(object) == "string") then
        return tostring(object)
    end

    local toDump = "{"

    for k, v in pairs(object) do
        if (type(k) == "number") then
            toDump = toDump .. "[" .. k .. "] = "
        elseif (type(k) == "string") then
            toDump = toDump .. k ..  "= "
        end

        if (type(v) == "number") then
            toDump = toDump .. v .. ","
        elseif (type(v) == "string") then
            toDump = toDump .. "\"" .. v .. "\", "
        else
            toDump = toDump .. self:dumpString(v) .. ", "
        end
    end

    toDump = toDump .. "}"

    return toDump
end