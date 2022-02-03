FlameManager = {
    maxFlameDist = 15,
    flameVelocity = 20,
    flames = {},
    nozzleOffset = Vec(0.3, -0.3, -1.1),
}

function FlameManager:throwFlames()
    if InputDown("lmb") then
        local camera = GetCameraTransform()
        local nozzle = TransformToParentTransform(camera, Transform(FlameManager.nozzleOffset))
        local fwd = TransformToParentVec(nozzle, Vec(0, 0, -1))
        local hit, dist, normal, shape = QueryRaycast(nozzle.pos, fwd, FlameManager.maxFlameDist, 0.1)
        local hitPoint = Transform(VecAdd(nozzle.pos, VecScale(fwd, dist)), nozzle.rot)
        local ammoUsed = Flamethrower.ammoPerSecond * GetTimeStep()

        table.insert(FlameManager.flames, Flame:new(nozzle, dist))
        Flamethrower:removeAmmo(ammoUsed)
    end
end

function FlameManager:emulateFlames()
    local distance = FlameManager.flameVelocity * GetTimeStep()

    for i, flame in ipairs(FlameManager.flames) do
        flame:tick(distance)

        if flame.distance > flame.maxDistance then
            table.remove(FlameManager.flames, i)
        end
    end
end
