-- Tool (presentation): tool body transform and HUD chrome. Pure client visuals.
Tool = {}

function Tool:tick()
    SetBool('hud.aimdot', false)
    self:setToolPosition()
end

function Tool:setToolPosition()
    if InputDown('usetool') and State:hasAmmo() and GetBool("game.player.canusetool") then
        local offset = Transform(Vec(0.3, -0.5, -0.9))
        SetToolTransform(offset, 0.1)
    else
        local offset = Transform(Vec(0.3, -0.5, -0.95))
        SetToolTransform(offset, 0.5)
    end
end
