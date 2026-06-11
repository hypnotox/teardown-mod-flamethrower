-- FlameLight (presentation): point lights over the active flames Simulation owns.
-- Extracted from the old Flame.tick. Reads Simulation:getFlames() -- a cross-seam
-- read that becomes a shared/predicted concern under multiplayer.
FlameLight = {}

function FlameLight:tick()
    local flames = Simulation:getFlames()

    for i = 1, #flames, 1 do
        local flame = flames[i]
        local speed = VecLength(flame.vel)

        if speed < 0.001 then
            speed = 0.001
        end

        local size = (flame.dist * 2) / speed
        PointLight(flame.pos, 1, 0.2, 0.01, size)
    end
end
