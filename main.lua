#include "scripts/flamethrower.lua"
#include "scripts/flame.lua"
#include "scripts/flameManager.lua"
#include "scripts/particleManager.lua"
#include "scripts/soundManager.lua"

function init()
    Flamethrower:init()
end

function tick(dt)
    if GetString("game.player.tool") == "hypnotox_flamethrower" and GetBool("game.player.canusetool") then
        Flamethrower:tick(dt)
    end
end

function update()
    if GetString("game.player.tool") == "hypnotox_flamethrower" and GetBool("game.player.canusetool") then
        Flamethrower:update()
    end
end