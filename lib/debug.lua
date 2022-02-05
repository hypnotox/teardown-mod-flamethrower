Debug = {
    enabled = false
}

function Debug:enable()
    self.enabled = true
    DebugPrint('Debug is enabled!')
end

function Debug:tick()
    Debug:watch('player', Debug:dumpString(GetPlayerTransform().pos))
    Debug:watch('playerRot', Debug:dumpString(GetPlayerTransform().rot))

    local tool = GetToolBody()
    local toolTransform = GetBodyTransform(tool)
    Debug:watch('tool', Debug:dumpString(toolTransform.pos))
    Debug:watch('toolRot', Debug:dumpString(toolTransform.rot))

    local fireStarterTransform = Flamethrower:getFireStarterTransform()
    Debug:watch('fireStarter', Debug:dumpString(fireStarterTransform.pos))
    Debug:watch('fireStarterRot', Debug:dumpString(fireStarterTransform.rot))
    Debug:cross(fireStarterTransform.pos, 0, 255, 0, 0.7)

    local nozzleTransform = Flamethrower:getNozzleTransform()
    Debug:watch('nozzle', Debug:dumpString(nozzleTransform.pos))
    Debug:watch('nozzleRot', Debug:dumpString(nozzleTransform.rot))
    Debug:cross(nozzleTransform.pos, 255, 0, 0, 0.7)

    local flameVelocity = Flamethrower:getFlameVelocity()
    Debug:watch('FlameVelocity', Debug:dumpString(flameVelocity))
    Debug:watch('FlameVelocityMagnitude', Debug:dumpString(VecLength(flameVelocity)))

    Debug:watch('FireCount', GetFireCount())
end

-- Debug functions --

function Debug:line(p0, p1, r, g, b, a)
    if not self.enabled then
        return
    end
    Debug:print('Drawing line!')

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
    if not self.enabled then
        return
    end

    if type(object) == 'table' then
        local s = '{ '
        for k, v in ipairs(object) do
            if type(k) ~= 'number' then
                k = '"' .. k .. '"'
            end
            s = s .. '[' .. k .. '] = ' .. self:dumpString(v) or '' .. ','
        end

        return s .. '} '
    end

    return tostring(object)
end