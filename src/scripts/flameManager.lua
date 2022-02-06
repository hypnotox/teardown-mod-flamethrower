FlameManager = {
    flames = {},
}

function FlameManager:throwFlames(flameVelocity, lifetime)
    if InputDown('usetool') then
        local nozzle = Flamethrower:getNozzleTransform()
        local fwd = TransformToParentVec(nozzle, Vec(0, 0, -1))
        local hit, maxDist, normal = QueryRaycast(nozzle.pos, fwd, 30, 0.10)

        table.insert(FlameManager.flames, Flame:new(nozzle, VecLength(flameVelocity), lifetime, hit, maxDist, normal))
        Flamethrower:ammoTick()
    end
end

function FlameManager:tick()
    for _, flame in ipairs(FlameManager.flames) do
        flame:tick()
    end
end

function FlameManager:update()
    for i, flame in ipairs(FlameManager.flames) do
        flame:update()

        if not flame.isAlive then
            table.remove(FlameManager.flames, i)
        end
    end
end
