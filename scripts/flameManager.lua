FlameManager = {
    maxFlameDist = 15,
    flameVelocity = 20,
    flames = {},
    nozzleOffset = Vec(0.3, -0.3, -1.1),
}

function FlameManager:throwFlames(flameVelocity, lifetime)
    if InputDown('usetool') then
        local nozzle = Flamethrower:getNozzleTransform()
        local fwd = TransformToParentVec(nozzle, Vec(0, 0, -1))
        local hit, maxDist = QueryRaycast(nozzle.pos, fwd, FlameManager.maxFlameDist, 0.15)

        table.insert(FlameManager.flames, Flame:new(nozzle, VecLength(flameVelocity) * 0.8, lifetime, maxDist))
        Flamethrower:ammoTick(ammoUsed)
    end
end

function FlameManager:emulateFlames()
    for i, flame in ipairs(FlameManager.flames) do
        flame:tick()

        if flame.lifetime < 0 or flame.dist > flame.maxDist then
            table.remove(FlameManager.flames, i)
        end
    end
end
