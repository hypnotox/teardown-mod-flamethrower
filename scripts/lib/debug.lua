function initDebug()
    Debug = {
        enabled = false,
        toggleKey = Input.home()
    }

    local function dumpTransform(transform)
        local t = TransformCopy(transform)
        local x, y, z = GetQuatEuler(t.rot)
        t.rot = {x, y, z}

        return Debug:dumpString(t)
    end

    function Debug:init()
        self.enabled = true
        Debug:print('KnobDecrease: ' .. GetString('savegame.mod.features.nozzle.keybinds.decrease'))
        Debug:print('KnobIncrease: ' .. GetString('savegame.mod.features.nozzle.keybinds.increase'))
        Debug:print('FireLimitOverrideEnabled: ' .. (GetBool('savegame.mod.features.fire_limit.enabled') and 'true' or 'false'))
        Debug:print('FireLimitValue: ' .. GetInt('savegame.mod.features.fire_limit.value'))
        Debug:print('DebugSlot: ' ..  (GetInt('savegame.mod.features.inventory.slot') or 6))
    end

    function Debug:tick()
        Debug:watch('player', dumpTransform(GetPlayerTransform()))
        Debug:watch('camera', dumpTransform(GetCameraTransform()))

        -- Tool
        local tool = GetToolBody()
        local toolTransform = GetBodyTransform(tool)
        Debug:watch('tool', dumpTransform(toolTransform))

        -- FireStarter
        local shape = FireStarter:getShape()
        local fireStarterTransform = TransformToParentTransform(
            Transform(GetShapeWorldTransform(shape).pos, toolTransform.rot),
            Engine:voxelCenterOffset()
        )
        Debug:watch('fireStarter', dumpTransform(fireStarterTransform))
        Debug:cross(fireStarterTransform.pos, 0, 255, 0, 0.7)

        -- Nozzle
        local nozzleTransform = Nozzle:getNozzleTransform()
        Debug:watch('nozzle', dumpTransform(nozzleTransform))
        Debug:cross(nozzleTransform.pos, 255, 0, 0, 0.7)

        local fwd = TransformToParentVec(nozzleTransform, Vec(0, 0, -1))
        local _, maxDist = QueryRaycast(nozzleTransform.pos, fwd, 100)
        Debug:line(nozzleTransform.pos, TransformToParentPoint(nozzleTransform, Vec(0, 0, -maxDist)), 255, 0, 0, 0.7)

        -- Knob
        local knobShape = Knob:getShape()
        local knobTransform = TransformToParentTransform(
            Transform(GetShapeWorldTransform(knobShape).pos, toolTransform.rot),
            Engine:voxelCenterOffset()
        )

        Debug:watch('knob', dumpTransform(knobTransform))
        Debug:cross(knobTransform.pos, 255, 0, 0, 0.7)

        -- FlameVelocity
        local flameVelocity = Nozzle:getFlameVelocity()
        Debug:watch('FlameVelocity', Debug:dumpString(flameVelocity))
        Debug:watch('FlameVelocityMagnitude', Debug:dumpString(VecLength(flameVelocity)))

        Debug:watch('FlamesCount', #Flamethrower.flames)
        Debug:watch('FireCount', GetFireCount())
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
    function Debug:dump(object, title)
        if title then
            self:print(title .. ': ' .. self:dumpString(object))
        else
            self:print(self:dumpString(object))
        end
    end

    function Debug:dumpString(object)
        if (type(object) == "number") or (type(object) == "string") or (type(object) == "boolean") then
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
end
