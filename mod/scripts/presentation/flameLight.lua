-- FlameLight (presentation): point lights over the active flames Simulation owns.
-- Extracted from the old Flame.tick. Reads Simulation:getFlames() -- a cross-seam
-- read that becomes a shared/predicted concern under multiplayer.
FlameLight = {}

function FlameLight:tick()
    local flames = Simulation:getFlames()

    for i = 1, #flames, 1 do
        local flame = flames[i]
        local size = (flame.dist * 2) / flame.speed
        PointLight(flame.transform.pos, 1, 0.2, 0.01, size)
    end
end
